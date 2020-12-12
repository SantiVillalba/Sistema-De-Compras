Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Net.Mail

Public Class _Default
    Inherits System.Web.UI.Page
    Public x As String
    Public connectionstring As String = ConfigurationManager.ConnectionStrings(ConfigurationManager.AppSettings("Conexion")).ToString()
    Public EmailActivo As String = ConfigurationManager.AppSettings("EmailActivo")
    Public Email As String = ConfigurationManager.AppSettings(EmailActivo)
    Public EmailPass As String = ConfigurationManager.AppSettings(EmailActivo & "Pass")

    Dim con As New SqlConnection(connectionstring)
    Dim ar As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Sub ArreglarCampo(ByRef campo As TextBox)
        campo.Text = campo.Text.Trim.Replace("'", "").Replace("""",
        "").Replace("*", "").Replace("+", "").Replace("-", "").Replace("/",
        "").Replace(":", "").Replace("`", "").Replace("<", "").Replace(">",
        "").Replace("=", "").Replace("&", "")
    End Sub

    Function comprobar(ByVal user As String) As Boolean
        If user Is System.DBNull.Value Then
            Return False
        Else
            Dim aux As Boolean = True
            Dim listanegra, x As String
            listanegra = "'*+-/:;`><&" & """"
            If user <> "" Then
                For Each x In user
                    If aux = True Then
                        If InStr(1, listanegra, x) > 0 Then
                            aux = False
                        Else
                            aux = True
                        End If
                    Else
                        Return False
                    End If
                Next
                If aux = True Then
                    Return True
                End If
            Else
                Return False
            End If
        End If
    End Function

    Sub LimpiarErroresRegistroU()
        lErroresU.Text = ""
        lErroresU.Visible = False
        lEFNac.Visible = False
        lEFNac.Text = ""
        lENombreU.Text = ""
        lEApellidoU.Text = ""
        lEDocU.Text = ""
        lEEmailU.Text = ""
        lELocalidadU.Text = ""
        lEDireccionU.Text = ""
        lETelefonosU.Text = ""
        lEUsuarioU.Text = ""
        lEPassU.Text = ""
        lEPass2U.Text = ""
        lENombreU.Visible = False
        lEApellidoU.Visible = False
        lEDocU.Visible = False
        lEEmailU.Visible = False
        lELocalidadU.Visible = False
        lEDireccionU.Visible = False
        lETelefonosU.Visible = False
        lEUsuarioU.Visible = False
        lEPassU.Visible = False
        lEPass2U.Visible = False
    End Sub

    Sub LimpiarRegistroU()
        LimpiarErroresRegistroU()
        pRegistrarse.Visible = False

        tNombreU.Text = ""
        tApellidoU.Text = ""
        dTDocU.SelectedIndex = 0
        tDocU.Text = ""
        tEmailU.Text = ""
        didProvU.SelectedIndex = 0
        tLocalidadU.Text = ""
        tDireccionU.Text = ""
        tTelefonosU.Text = ""
        tUsuarioU.Text = ""
        tPassU.Text = ""
        tPass2U.Text = ""
    End Sub

    Public Function ValidateEmail(ByVal email As String) As Boolean
        Dim emailRegex As New System.Text.RegularExpressions.Regex("^(?<user>[^@]+)@(?<host>.+)$")
        Dim emailMatch As System.Text.RegularExpressions.Match = emailRegex.Match(email)
        Return emailMatch.Success
    End Function

    Sub SoloNumeros(ByRef campo As TextBox)
        Dim cam As String = campo.Text.Trim, salida As String = "", c As String
        For Each c In cam
            If IsNumeric(c) Then salida &= c
        Next
        campo.Text = salida
    End Sub

    Function VNum(ByVal NTexto As String) As Decimal
        ' transforma un texto con algo, que puede ser un numero con coma o punto o perro, y devuelve un valor decimal siempre
        Return CDec(Val(NTexto.Trim.Replace(",", ".")))
    End Function

    Function NumSQL(ByVal numero As String) As String
        ' recibe un numero desde un textbox por ejemplo, lo verifica como numero valido, y luego le cambia la coma por punto para
        ' para que sea valido en una sentencia sql, luego lo devuelve
        Return CStr(VNum(numero)).Trim.Replace(",", ".")
    End Function

    Function RellenarNum(ByVal numero As Integer, ByVal cantidad As Integer) As String
        'Rellena con 0s adelante el numero. ideal para dias y meses:
        'RellenaNum(3,2) ---> "03" RellenaNum(3,4) ---> "0003"
        Dim snum As String = CStr(numero).Trim
        Return "00000000000000000000".Substring(0, cantidad - snum.Length) & snum
    End Function

    Function FechaSQL(ByVal fecha As Date) As String
        ' Devuelve fecha en el formato "AAAAMMDD"
        Return "'" & RellenarNum(Year(fecha), 4) & RellenarNum(Month(fecha), 2) & RellenarNum(fecha.Day, 2) & "'"
    End Function

    Public Function AñoMes(ByVal fecha As Date) As String
        'devuelve AAAA-MM
        Return RellenarNum(Year(fecha), 4) & "-" & RellenarNum(Month(fecha), 2)
    End Function

    Public Function Vstr(ByVal cosa As Object) As String
        If IsDBNull(cosa) Then Return "" Else Return CStr(cosa)
    End Function

    Function CalcularEdad(ByVal FechaNac As Date) As Integer
        Dim edad As Integer = DateTime.Today.AddTicks(-FechaNac.Ticks).Year - 1
        Return edad
    End Function

    Sub ControlDeNacimiento(ByRef xtF_nac As TextBox, ByRef ok As Boolean,
                            ByRef xlEFNac As Label, ByRef xlEdad As Label,
                            ByVal Valida18 As Boolean, ByRef FechaNacimiento As Date)
        ArreglarCampo(xtF_nac)
        xlEFNac.Visible = False
        If xtF_nac.Text.Length < 6 Then
            ok = False
            xlEFNac.Text &= "El campo fecha de nacimiento debe tener 6 números"
            xlEdad.Text = "0"
            xlEFNac.Visible = True
        Else
            Dim FechaX As String = xtF_nac.Text
            Dim AñoX As Integer = VNum(FechaX.Substring(4, 2))
            If AñoX + 2000 > Date.Today.Year Then AñoX += 1900 Else AñoX += 2000
            FechaX = AñoX.ToString.Trim & "-" & FechaX.Substring(2, 2) & "-" & FechaX.Substring(0, 2)
            If Not IsDate(FechaX) Then
                ok = False
                xlEFNac.Text &= "El campo fecha de nacimiento, es una fecha inválida."
                xlEdad.Text = "0"
                xlEFNac.Visible = True
            Else
                Dim dFechax As Date
                dFechax = CDate(FechaX)
                FechaNacimiento = dFechax
                If dFechax > Date.Today Then
                    ok = False
                    xlEFNac.Text &= "Nació en el futuro...."
                    xlEdad.Text = "0"
                    xlEFNac.Visible = True
                Else
                    Dim Edad As Integer = CalcularEdad(dFechax)
                    xlEdad.Text = Edad
                    If Edad < 18 And Valida18 Then
                        ok = False
                        xlEFNac.Text &= "Debe ser mayor de edad (18 años)."
                        xlEdad.Text = "0"
                        xlEFNac.Visible = True
                    End If
                End If
            End If
        End If
    End Sub

    Public Function SQL_Accion(ByVal Sql_de_accion As String) As Boolean
        ' Ejecuta la consulta de accion 'sql_de_accion' abriendo la conexion automaticamente
        ' se da cuenta si es de insert, update o delete, porque mira dentro de la sentencia que se le pasa
        ' devuelve true si se pudo hacer y false si hubo algun error

        Dim adapter As New SqlDataAdapter, salida As Boolean = True
        Try
            If con.State = ConnectionState.Closed Then con.Open()
            If Sql_de_accion.ToUpper.IndexOf("INSERT") Then
                adapter.InsertCommand = New SqlCommand(Sql_de_accion, con)
                adapter.InsertCommand.ExecuteNonQuery()
            ElseIf Sql_de_accion.ToUpper.IndexOf("UPDATE") Then
                adapter.UpdateCommand = New SqlCommand(Sql_de_accion, con)
                adapter.UpdateCommand.ExecuteNonQuery()
            ElseIf Sql_de_accion.ToUpper.IndexOf("DELETE") Then
                adapter.DeleteCommand = New SqlCommand(Sql_de_accion, con)
                adapter.DeleteCommand.ExecuteNonQuery()
            Else
                salida = False
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
            salida = False
        End Try
        Return salida
    End Function

    Function LeeUnCampo(ByVal sql As String, ByVal campo As String) As Object
        'Se le pasa un SELECT de SQL con un campo y devuelve el valor del 
        'campo como object. Se supone que devuelve nada o 1 registro (no mas que 1)
        'Ejemplo: valor=LeeUnCampo("select cosa from tabla where condi=1","cosa")
        'valor tomarpa cosa. Si no encuentra nada, devuelve "**NADA**".Si hay error
        'devuelve "**ERROR**".
        Dim da1 As New SqlDataAdapter(sql, con)
        Dim ds1 As New DataSet
        Try
            If con.State = ConnectionState.Closed Then con.Open()
            da1.Fill(ds1, "datos")
            If ds1.Tables("datos").Rows.Count < 1 Then
                Return "**NADA**"
            Else
                Return ds1.Tables("datos").Rows(0)(campo)
            End If
        Catch ex As Exception
            Return "**ERROR**"
        End Try
    End Function

    Public Function YaExisteSQL(ByVal sql As String) As Boolean
        'Se le pasa un select de sql que en teoria busca algo,
        'por ejemplo un numero de cheque, si hay registros la funcion devuelve
        'true, estilo "el cheque ya existe", si no está, devuelve false
        'Dim ar As String
        Dim con As New SqlConnection(connectionstring)
        Dim da1 As New SqlDataAdapter(sql, con)
        Dim ds1 As New DataSet
        da1.Fill(ds1, "afidesc")
        If ds1.Tables("afidesc").Rows.Count < 1 Then
            Return False
        Else
            Return True
        End If
    End Function

    Sub Loguea()

        Dim usu As String = tUsuario.Text.Trim.ToUpper, pass As String = tClave.Text.Trim

        If comprobar(tUsuario.Text.Trim) = False Or comprobar(tClave.Text.Trim) = False Then
            lErrorLogin.Text = "El usuario o la clave son incorrectos. Revise por favor."
            lErrorLogin.Visible = True
            Exit Sub
        End If

        Dim da1 As New SqlDataAdapter("select * from " & Session("QueEs") & " where upper(ltrim(rtrim(usuario)))='" & usu & "' and (ltrim(rtrim(pass)))='" & pass & "'", con)

        Dim ds1 As New DataSet

        da1.Fill(ds1, "Login")

        If ds1.Tables("Login").Rows.Count = 0 Then
            lErrorLogin.Text = "El usuario o clave son incorrectos, revise los datos."
            lErrorLogin.Visible = True
            Exit Sub
        End If

        Select Case Session("QueEs")
            Case "Usuarios"

                Dim estado As String = ds1.Tables("Login").Rows(0)("Estado").ToString.Trim

                If estado = "Bloqueado" Then
                    lErrorLogin.Text = "El usuario ingresado está bloqueado."
                    lErrorLogin.Visible = True
                    Exit Sub
                End If

                Session("idUsuario") = ds1.Tables("Login").Rows(0)("idUsuario")
                Session("Usuario") = usu
                Session("Password") = pass
                Session("TipoDocumento") = ds1.Tables("Login").Rows(0)("tDoc")
                Session("Documento") = ds1.Tables("Login").Rows(0)("Doc").ToString.Trim
                Session("ApellidoYNombre") = ds1.Tables("Login").Rows(0)("Nombre").ToString.Trim & " " & ds1.Tables("Login").Rows(0)("Apellido").ToString.Trim
                Session("Email") = ds1.Tables("Login").Rows(0)("Email").ToString.Trim
                Session("idprov") = ds1.Tables("Login").Rows(0)("idprov").ToString.Trim
                Session("Localidad") = ds1.Tables("Login").Rows(0)("Localidad").ToString.Trim
                Session("Direccion") = ds1.Tables("Login").Rows(0)("Direccion").ToString.Trim
                Session("Telefonos") = ds1.Tables("Login").Rows(0)("Telefonos").ToString.Trim

                lBienvenidoAreaU.Text = "Bienvenido " & Session("ApellidoYNombre") & ", a tu Área de Usuario."

                botonHacerPedido.Visible = True
                botonModificarDatos.Visible = True
                bAreaAdministrador.Visible = False

                LimpiarRegistroU()

                pLogin.Visible = False
                pAreaUsuario.Visible = True

            Case "Administradores"
                Session("idUsuario") = ds1.Tables("Login").Rows(0)("idUsuario")
                Session("Usuario") = usu
                Session("Password") = pass
                Session("TipoDocumento") = ds1.Tables("Login").Rows(0)("tDoc")
                Session("Documento") = ds1.Tables("Login").Rows(0)("Doc").ToString.Trim
                Session("ApellidoYNombre") = ds1.Tables("Login").Rows(0)("Nombre").ToString.Trim & " " & ds1.Tables("Login").Rows(0)("Apellido").ToString.Trim
                Session("Email") = ds1.Tables("Login").Rows(0)("Email").ToString.Trim
                Session("idprov") = ds1.Tables("Login").Rows(0)("idprov").ToString.Trim
                Session("Localidad") = ds1.Tables("Login").Rows(0)("Localidad").ToString.Trim
                Session("Direccion") = ds1.Tables("Login").Rows(0)("Direccion").ToString.Trim
                Session("Telefonos") = ds1.Tables("Login").Rows(0)("Telefonos").ToString.Trim
                lBienvenidoAreaU.Text = "Bienvenido " & Session("ApellidoYNombre") & ", a tu Área de Administrador."

                bAreaAdministrador.Visible = True

                LimpiarRegistroU()

                pLogin.Visible = False
                pAreaUsuario.Visible = True
        End Select
    End Sub

    Sub LimpiarLogin()
        lErrorLogin.Text = ""
        lErrorLogin.Visible = False
        tUsuario.Text = ""
        tClave.Text = ""
        pRegistrarse.Visible = False
    End Sub

    Sub LimpiarErroresCambios()
        EEmailU.Text = ""
        ELocalidadU.Text = ""
        EDireccionU.Text = ""
        ETelefonosU.Text = ""
        EUsuarioU.Text = ""
        EPassU.Text = ""
        lErrorU.Text = ""

        EEmailU.Visible = False
        ELocalidadU.Visible = False
        EDireccionU.Visible = False
        ETelefonosU.Visible = False
        EUsuarioU.Visible = False
        EPassU.Visible = False
        lErrorU.Visible = False
    End Sub

    Sub CargarProductos()
        Dim x As Integer = 0, cosa As String
        Dim da2 As New SqlDataAdapter("select * from Web_Productos order by Producto", con)
        Dim ds2 As New DataSet

        dProducto.Items.Clear()
        da2.Fill(ds2, "dato")

        If ds2.Tables("dato").Rows.Count = 0 Then
            dProducto.Items.Add("No hay Productos disponibles")
            Exit Sub
        End If

        For x = 0 To ds2.Tables("dato").Rows.Count - 1
            cosa = ds2.Tables("dato").Rows(x)("Producto").ToString.Trim
            dProducto.Items.Add(cosa)
        Next

        dProducto.SelectedIndex = 0
        lCosaAgregar.Text = dProducto.SelectedItem.ToString
        lQueEs.Text = "Producto"
    End Sub

    Sub CargaTemporal()

        Dim idu As Integer = VNum(Session("idUsuario"))
        Dim consulta As String = "select item, cantidad from Web_Pedidos_Temporal where Num_Cli=" & Session("idUsuario") & " order by item"
        Dim da1 As New SqlDataAdapter(consulta, con)
        Dim ds1 As New DataSet

        da1.Fill(ds1, "histo")
        gListaPedido.DataSource = ds1.Tables("histo")
        gListaPedido.DataBind()

        If ds1.Tables("histo").Rows.Count = 0 Then
            lErrorHistorico.Text = ""
            gListaPedido.Visible = False
            botonSolicitarPedido.Visible = False
            botonQuitarTodos.Visible = False
            lErrorPedido.Visible = False
        Else
            gListaPedido.Visible = True
            botonSolicitarPedido.Visible = True
            botonQuitarTodos.Visible = True
            lErrorPedido.Visible = True
        End If

    End Sub

    Protected Sub bInstrucciones_Click(sender As Object, e As EventArgs) Handles bInstrucciones.Click

        If bInstrucciones.Text = "Abrir instrucciones" Then
            bInstrucciones.Text = "Cerrar instrucciones"
            lInstrucciones.Visible = True
        Else
            bInstrucciones.Text = "Abrir instrucciones"
            lInstrucciones.Visible = False
        End If

    End Sub

    Protected Sub dProducto_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dProducto.SelectedIndexChanged

        lCosaAgregar.Text = dProducto.SelectedItem.ToString
        lQueEs.Text = "Producto"

    End Sub

    Protected Sub gPedido_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gListaPedido.RowCommand

        Dim index As Integer = Convert.ToInt32(e.CommandArgument)
        Dim row As GridViewRow = gListaPedido.Rows(index)
        Dim Item As String = row.Cells(1).Text, en As String = Chr(13) & Chr(10)
        Dim consulta As String = "delete web_pedidos_temporal where ltrim(rtrim(item))='" & Item & "' and num_cli=" & VNum(Session("idUsuario"))

        lErrorPedido.Text = ""
        If (e.CommandName = "Quitar") Then
            If SQL_Accion(consulta) = False Then
                lErrorPedido.Text = "No se pudo quitar el item de la lista"
                Exit Sub
            End If
            CargaTemporal()
        End If
    End Sub

    Protected Sub MostrarProductos()

        Dim x As Integer = 0, cosa As String
        Dim da2 As New SqlDataAdapter("select * from Web_Productos order by Producto", con)
        Dim ds2 As New DataSet

        dCambiarProductos.Items.Clear()
        da2.Fill(ds2, "dato")

        If ds2.Tables("dato").Rows.Count = 0 Then
            dCambiarProductos.Items.Add("No hay Productos disponibles")
            Exit Sub
        End If

        For x = 0 To ds2.Tables("dato").Rows.Count - 1
            cosa = ds2.Tables("dato").Rows(x)("Producto").ToString.Trim
            dCambiarProductos.Items.Add(cosa)
        Next

    End Sub
    Sub LimpiarErroresProductos()
        lErrorNombre.Text = ""
        lErrorPrecio.Text = ""
        lErrorStock.Text = ""
        lErrorAgregarProducto.Text = ""
        lErrorCNombre.Text = ""
        lErrorCPrecio.Text = ""
        lErrorCStock.Text = ""
        lErrorCProducto.Text = ""

        lErrorNombre.Visible = False
        lErrorPrecio.Visible = False
        lErrorStock.Visible = False
        lErrorAgregarProducto.Visible = False
        lErrorCNombre.Visible = False
        lErrorCPrecio.Visible = False
        lErrorCStock.Visible = False
        lErrorCProducto.Visible = False
    End Sub

    Sub LimpiarModificacion()
        tCambiarNom.Text = ""
        tCambiarPrecio.Text = ""
        tCambiarStock.Text = ""
    End Sub

    Sub CargaHistorico()
        lErrorHistorico.Text = ""

        Dim idU As Integer = VNum(Session("idUsuario"))

        Dim da1 As New SqlDataAdapter("SELECT npedido, fecha, estado FROM web_pedidos WHERE num_cli=" &
                                      idU & "and estado<>'Enviado' ORDER BY npedido DESC", con)
        Dim ds1 As New DataSet

        da1.Fill(ds1, "histo")
        gHistorico.DataSource = ds1.Tables("histo")
        gHistorico.DataBind()

        If ds1.Tables("histo").Rows.Count = 0 Then
            lErrorHistorico.Text = "No hay pedidos anteriores o hubo un error al cargarlos. Reintente más tarde."
            gHistorico.Visible = False
        Else
            gHistorico.Visible = True
        End If

        pTodoslospedidos.Visible = False
    End Sub

    Protected Sub gHistorico_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gHistorico.RowCommand

        Dim index As Integer = Convert.ToInt32(e.CommandArgument)
        Dim row As GridViewRow = gHistorico.Rows(index)
        Dim Npedido As Integer = VNum(row.Cells(2).Text), en As String = Chr(13) & Chr(10)

        If (e.CommandName = "Ver") Then
            Label3.Text = Npedido
            lErrorVerUnPedido.Text = ""

            Dim da1 As New SqlDataAdapter("SELECT WEB_Pedidos_Detalle.Item, WEB_Pedidos_Detalle.Cantidad FROM WEB_Pedidos_Detalle INNER JOIN Web_Productos ON WEB_Pedidos_Detalle.Item = Web_Productos.Producto WHERE WEB_Pedidos_Detalle.NPedido=" & Npedido & " ORDER BY Web_Productos.Cod", con)
            Dim ds1 As New DataSet

            da1.Fill(ds1, "histo")
            gVerUnPedido.DataSource = ds1.Tables("histo")
            gVerUnPedido.DataBind()

            If ds1.Tables("histo").Rows.Count = 0 Then
                lErrorHistorico.Text = "Hubo un error al cargar los items del pedido N°" & Npedido &
                    ", porque no se leyó ninguno. Reintente más tarde."
                gVerUnPedido.Visible = False
            Else
                gVerUnPedido.Visible = True
            End If

            pHistorico.Visible = False
            pVerUnPedido.Visible = True
        End If

        If (e.CommandName = "Anular") Then
            'tengo que mirar primero el estado del pedido
            '(pudo haber dejado abierto con solicitado pero ya se lo enviaron)

            lErrorHistorico.Text = ""

            Dim da1 As New SqlDataAdapter("SELECT Estado FROM WEB_Pedidos WHERE NPedido=" & Npedido, con)
            Dim ds1 As New DataSet

            da1.Fill(ds1, "histo")

            If ds1.Tables("histo").Rows.Count = 0 Then
                lErrorHistorico.Text = "No puedo acceder al pedido N°" & Npedido & "Reintente más tarde."
                Exit Sub
            Else
                Dim Estado As String = ds1.Tables("histo")(0)("Estado").ToString.Trim

                If Estado <> "Solicitado" Then
                    lErrorHistorico.Text = "El pedido tiene estado = '" & Estado & "' y ya no puede cancelar por web (sólo 'solicitado'). LLame a la fábrica por favor."
                    Exit Sub
                Else
                    If Estado = "Anulado" Then
                        lErrorHistorico.Text = "El pedido n° " & Npedido & ", Ya estaba anulado..."
                        Exit Sub
                    End If
                    lErrorHistorico.Text = ""
                    If SQL_Accion("UPDATE WEB_Pedidos SET Estado='Anulado' WHERE NPedido=" & Npedido) = False Then
                        lErrorHistorico.Text = "No he podido cambiar el estado, hubo algún error de conexión. Por favor, reintente más tarde o llame a la fábrica para avisar de la anulacion."
                        Exit Sub
                    Else
                        lPedidoAnulado.Text = "El pedido N° " & Npedido & ", fue ANULADO."
                        pHistorico.Visible = False
                        pPedidoAnular.Visible = True
                    End If
                End If
            End If
        End If
    End Sub
    Protected Sub Button8_Click(sender As Object, e As EventArgs) Handles Button8.Click
        CargaHistorico()
    End Sub

    Protected Sub bTerminarHistorico_Click(sender As Object, e As EventArgs) Handles bTerminarHistorico.Click
        pHistorico.Visible = False
        pPedidos.Visible = True
    End Sub

    Sub CargarHistoricoAdmin()
        lErrorHistoricoAdmin.Text = ""

        Dim idU As Integer = VNum(Session("idUsuario"))
        Dim da1 As New SqlDataAdapter("SELECT NPedido, NUM_CLI, Fecha, Estado FROM WEB_Pedidos ORDER BY NPedido DESC", con)
        Dim ds1 As New DataSet

        da1.Fill(ds1, "histo")
        gTodosLosPedidos.DataSource = ds1.Tables("histo")
        gTodosLosPedidos.DataBind()

        If ds1.Tables("histo").Rows.Count = 0 Then
            lErrorHistoricoAdmin.Text = "No hay pedidos anteriores o hubo un error al cargarlos."
            gTodosLosPedidos.Visible = False
        Else
            gTodosLosPedidos.Visible = True
        End If
        pAreaAdministrador.Visible = False
        pTodoslospedidos.Visible = True
    End Sub

    Protected Sub gTodosLosPedidos_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gTodosLosPedidos.RowCommand

        Dim index As Integer = Convert.ToInt32(e.CommandArgument)
        Dim row As GridViewRow = gTodosLosPedidos.Rows(index)
        Dim Npedido As Integer = VNum(row.Cells(3).Text), en As String = Chr(13) & Chr(10)

        If (e.CommandName = "Ver") Then
            lNumeroPedidoAdmin.Text = "Pedido N°" & Npedido
            lErrorVerPedidoAdmin.Text = ""

            Dim da1 As New SqlDataAdapter("SELECT WEB_Pedidos_Detalle.Item, WEB_Pedidos_Detalle.Cantidad " &
                                          "FROM WEB_Pedidos_Detalle INNER JOIN Web_Productos ON WEB_Pedidos_Detalle.Item =" &
                                          " Web_Productos.Producto WHERE WEB_Pedidos_Detalle.NPedido=" & Npedido &
                                          " ORDER BY Web_Productos.Cod", con)
            Dim ds1 As New DataSet

            da1.Fill(ds1, "histo")
            gVerPedidoAdmin.DataSource = ds1.Tables("histo")
            gVerPedidoAdmin.DataBind()

            If ds1.Tables("histo").Rows.Count = 0 Then
                lErrorVerPedidoAdmin.Text = "Hubo un error al cargar los items del pedido N°" & Npedido & " porque no se leyó ninguno."
                gVerUnPedido.Visible = False
            Else
                gVerUnPedido.Visible = True
            End If

            pTodoslospedidos.Visible = False
            pVerPedidoAdmin.Visible = True
        End If

        If (e.CommandName = "Anular") Then
            lErrorHistoricoAdmin.Text = ""
            lErrorHistoricoAdmin.Visible = False

            Dim da1 As New SqlDataAdapter("SELECT Estado FROM WEB_Pedidos WHERE NPedido=" & Npedido, con)
            Dim ds1 As New DataSet

            da1.Fill(ds1, "histo")

            If ds1.Tables("histo").Rows.Count = 0 Then
                lErrorHistoricoAdmin.Text = "No se pudo acceder al pedido N°" & Npedido
                lErrorHistoricoAdmin.Visible = True
                Exit Sub
            Else
                Dim Estado As String = ds1.Tables("histo")(0)("Estado").ToString.Trim

                If Estado = "Anulado" Then
                    lErrorHistoricoAdmin.Text = "El pedido ya había sido anulado."
                    lErrorHistoricoAdmin.Visible = True
                    Exit Sub
                End If

                If Estado = "Enviado" Then
                    lErrorHistoricoAdmin.Text = "El pedido ya fue enviado."
                    lErrorHistoricoAdmin.Visible = True
                    Exit Sub
                End If

                lErrorHistoricoAdmin.Text = ""

                If SQL_Accion("UPDATE WEB_Pedidos SET Estado='Anulado' WHERE NPedido=" & Npedido) = False Then
                    lErrorHistoricoAdmin.Text = "No se pudo cambiar el estado debido a algún error de conexión."
                    lErrorHistoricoAdmin.Visible = True
                    Exit Sub
                Else
                    pTodoslospedidos.Visible = False
                    pPedidoAnuladoAdmin.Visible = True
                    lPedidoAnuladoAdmin.Text = "El pedido N°" & Npedido & " fue anulado."
                    Exit Sub
                End If

            End If
        End If

        If (e.CommandName = "Editar") Then
            lErrorHistoricoAdmin.Text = ""
            lEditarNumeroPedido.Text = Npedido

            lErrorEditarPedido.Visible = False
            lErrorEditarPedido.Text = ""

            Dim da1 As New SqlDataAdapter("SELECT Estado FROM WEB_Pedidos WHERE NPedido=" & Npedido, con)
            Dim ds1 As New DataSet

            da1.Fill(ds1, "histo")

            If ds1.Tables("histo").Rows.Count = 0 Then
                lErrorHistoricoAdmin.Text = "No se pudo acceder al pedido N°" & Npedido
                lErrorHistoricoAdmin.Visible = True
                Exit Sub
            Else
                Dim Estado As String = ds1.Tables("histo")(0)("Estado").ToString.Trim

                If Estado = "Anulado" Then
                    lErrorHistoricoAdmin.Text = "El pedido no se puede editar porque fue anulado."
                    lErrorHistoricoAdmin.Visible = True
                    Exit Sub
                ElseIf Estado = "Enviado" Then
                    lErrorHistoricoAdmin.Text = "El pedido ya ha sido enviado."
                    lErrorHistoricoAdmin.Visible = True
                    Exit Sub
                Else
                    lErrorHistoricoAdmin.Text = ""

                    Dim da2 As New SqlDataAdapter("SELECT WEB_Pedidos_Detalle.Item, WEB_Pedidos_Detalle.Cantidad " &
                                          "FROM WEB_Pedidos_Detalle INNER JOIN Web_Productos ON WEB_Pedidos_Detalle.Item =" &
                                          " Web_Productos.Producto WHERE WEB_Pedidos_Detalle.NPedido=" & Npedido &
                                          " ORDER BY Web_Productos.Cod", con)
                    Dim ds2 As New DataSet

                    da2.Fill(ds2, "histo")
                    gEditarPedido.DataSource = ds2.Tables("histo")
                    gEditarPedido.DataBind()

                    If ds2.Tables("histo").Rows.Count = 0 Then
                        lErrorEditarPedido.Text = "Hubo un error al cargar los items del pedido N°" & Npedido & " porque no se leyó ninguno."
                        lErrorEditarPedido.Visible = True
                        gEditarPedido.Visible = False
                    Else
                        gEditarPedido.Visible = True
                    End If

                    pTodoslospedidos.Visible = False
                    pEditarPedido.Visible = True
                End If
            End If
        End If

    End Sub
    Protected Sub gEditarPedido_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gEditarPedido.RowCommand

        Dim index As Integer = Convert.ToInt32(e.CommandArgument)
        Dim row As GridViewRow = gEditarPedido.Rows(index)
        Dim Item As String = row.Cells(1).Text
        Dim Cantidad As String = row.Cells(2).Text
        Dim en As String = Chr(13) & Chr(10)
        Dim Npedido As Integer = Convert.ToInt32(lEditarNumeroPedido.Text)
        Dim consulta As String = "DELETE WEB_Pedidos_Detalle WHERE ltrim(rtrim(item))='" & Item & "' AND npedido=" & Npedido
        Dim id As String = lEditarNumeroPedido.Text

        Dim da2 As New SqlDataAdapter("SELECT Email FROM Usuarios WHERE idUsuario=" & id, con)
        Dim ds2 As New DataSet

        da2.Fill(ds2, "dato")

        Dim email As String = ds2.Tables("dato")(0)("email").ToString.Trim()

        lErrorEditarPedido.Text = ""

        If (e.CommandName = "Quitar") Then
            If SQL_Accion(consulta) = False Then
                lErrorEditarPedido.Text = "No se pudo quitar el item de la lista"
                Exit Sub
            End If

            lErrorHistoricoAdmin.Text = "El pedido N°" & Npedido & " ha sido modificado."
            lErrorHistoricoAdmin.Visible = True

            CargarHistoricoAdmin()
            EnviarMail(email, "Distribuidora - Modificación de pedido", "Se ha quitado lo siguiente del pedido N°" & Npedido & ":" & en & en & "Producto: " & Item & en & "Cantidad: " & Cantidad & en)

            pEditarPedido.Visible = False
            pTodoslospedidos.Visible = True
        End If

    End Sub

    Function EnviarMail(ByVal EmailDestino As String, ByVal Subject As String, ByVal Mensaje As String) As String

        'Devuelve "OK" si lo envio, sino, devuelve el mensaje de error producido
        Dim Resultado As String = "OK"
        Dim SmtpServer As New SmtpClient()
        Dim mail As New MailMessage()

        Try

            mail = New MailMessage()

            mail.From = New MailAddress(Email, "distribuidora unlz")
            mail.To.Add(EmailDestino)
            mail.Subject = Subject
            mail.Body = Mensaje
            mail.IsBodyHtml = False
            mail.Priority = MailPriority.Normal

            If EmailActivo = "EmailGmail" Then
                SmtpServer.Credentials = New Net.NetworkCredential(Email, EmailPass)
                SmtpServer.Host = "smtp.gmail.com"
                SmtpServer.Port = 587
                SmtpServer.EnableSsl = True
            Else
                'para EmailDonWeb
                'SmtpServer.Host = "Localhost"
                SmtpServer.Credentials = New Net.NetworkCredential(Email, EmailPass)
                SmtpServer.Host = "dtcwin033.ferozo.com"
                SmtpServer.Port = 465
                SmtpServer.EnableSsl = True

            End If
            SmtpServer.Send(mail)
        Catch
            Resultado = Err.Description
        End Try
        mail.Dispose()

        Return Resultado

    End Function

    Protected Sub CargarAdminUsuarios()
        Dim consulta As String = "SELECT idUsuario, Nombre, Apellido, Estado FROM Usuarios"
        Dim da As New SqlDataAdapter(consulta, con)
        Dim ds As New DataSet
        da.Fill(ds, "datos")
        gListaDeUsuarios.DataSource = ds.Tables("datos")
        gListaDeUsuarios.DataBind()
    End Sub

    Protected Sub gListaDeUsuarios_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gListaDeUsuarios.RowCommand

        Dim index As Integer = Convert.ToInt32(e.CommandArgument)
        Dim row As GridViewRow = gListaDeUsuarios.Rows(index)
        Dim id As Integer = VNum(row.Cells(3).Text)

        If (e.CommandName = "Eliminar") Then
            lEliminarUsuarioNumero.Text = id
            lErrorEliminarUsuario.Text = ""
            pUsuarios.Visible = False
            pEliminarUsuario.Visible = True
        End If

        If (e.CommandName = "Bloquear") Then
            Dim da1 As New SqlDataAdapter("SELECT Estado FROM Usuarios WHERE idUsuario=" & id, con)
            Dim ds1 As New DataSet

            da1.Fill(ds1, "dato")

            If ds1.Tables("dato").Rows.Count = 0 Then
                lErrorGestionUsuario.Text = "Se produjo un error"
                lErrorGestionUsuario.Visible = True
                Exit Sub
            Else
                Dim estado As String = ds1.Tables("dato")(0)("estado").ToString.Trim

                If estado = "Bloqueado" Then
                    lErrorGestionUsuario.Text = "El usuario ya esta bloqueado."
                    lErrorGestionUsuario.Visible = True
                    Exit Sub
                Else
                    lBloquearUsuarioNumero.Text = id
                    lErrorBloquearUsuario.Text = ""
                    pUsuarios.Visible = False
                    pBloquearUsuario.Visible = True
                End If
            End If
        End If

        If (e.CommandName = "Desbloquear") Then
            Dim da1 As New SqlDataAdapter("SELECT Estado FROM Usuarios WHERE idUsuario=" & id, con)
            Dim ds1 As New DataSet

            da1.Fill(ds1, "dato")

            If ds1.Tables("dato").Rows.Count = 0 Then
                lErrorGestionUsuario.Text = "Se produjo un error"
                lErrorGestionUsuario.Visible = True
                Exit Sub
            Else
                Dim estado As String = ds1.Tables("dato")(0)("estado").ToString.Trim

                If estado = "Activo" Then
                    lErrorGestionUsuario.Text = "El usuario no esta bloqueado."
                    lErrorGestionUsuario.Visible = True
                    Exit Sub
                Else
                    If SQL_Accion("UPDATE Usuarios SET Estado='Activo' WHERE idUsuario=" & id) = False Then
                        lErrorGestionUsuario.Text = "Se produjo un error al desbloquear al usuario."
                        lErrorGestionUsuario.Visible = True
                        Exit Sub
                    Else
                        lConfirmacionDeCambio.Text = "El usuario ha sido desbloqueado."
                        lConfirmacionDeCambio.Visible = True
                        pConfirmacionDeCambio.Visible = True
                        pUsuarios.Visible = False
                    End If
                End If
            End If
        End If

    End Sub

    Public Function CreaCodigo(ByVal cantCaracteres As Integer) As String
        'crea un codigo de tantos caracteres como cantCaracteres, mezclando números y letras mayúsculas
        Dim strRand As String = Nothing, r As New Random, c As String, i As Integer

        For i = 0 To cantCaracteres - 1
            If Math.Round(r.Next(0, 2)) = 0 Then
                c = Chr(Math.Round(r.Next(48, 58)))
            Else
                c = Chr(Math.Round(r.Next(65, 91)))
            End If
            strRand &= c
        Next

        Return strRand

    End Function



    Protected Sub bPortada_Click(sender As Object, e As ImageClickEventArgs) Handles bPortada.Click
        pPortada.Visible = False
        pLoginMenu.Visible = True
    End Sub

    Protected Sub bEntrar_Click(sender As Object, e As EventArgs) Handles bEntrar.Click
        Session("QueEs") = "Usuarios"
        Loguea()
    End Sub

    Protected Sub botonRecuperarClave_Click(sender As Object, e As EventArgs) Handles botonRecuperarClave.Click

        Dim usu As String = tUsuario.Text.Trim.ToUpper, email As String, xusuario As String, mensaje As String, pass As String
        Dim en As String = Chr(13) & Chr(10)

        If comprobar(usu) = False Then
            lReenviarClave.Text = "*** El usuario es incorrecto. Revisá por favor.***"
            lReenviarClave.Visible = True
            Exit Sub
        End If

        Dim da2 As New SqlDataAdapter("SELECT ltrim(rtrim(nombre)) + ' ' + ltrim(rtrim(apellido)) As usuario, pass,email FROM Usuarios WHERE upper(ltrim(rtrim(usuario)))='" & usu & "'", con)
        Dim ds2 As New DataSet

        da2.Fill(ds2, "Login")
        If ds2.Tables("Login").Rows.Count = 0 Then
            lReenviarClave.Text = "*** El usuario es incorrecto. Revisá por favor. ***"
            lReenviarClave.Visible = True
            Exit Sub
        End If
        email = ds2.Tables("Login").Rows(0)("email").ToString.Trim.ToLower
        pass = ds2.Tables("Login").Rows(0)("pass").ToString.Trim.ToLower
        xusuario = ds2.Tables("Login").Rows(0)("usuario").ToString.Trim

        mensaje = "Hola " & xusuario & "." & en & en & "Le escribimos desde distribuidora UNLZ, respondiendo a su pedido" &
            "de recuperacion de clave." & en & en & "Su usuario es " & """" & usu & """" & en & "Su clave es " &
            """" & pass & """" & en & en & "Ya podes volver a entrar y armar tus pedidos!" & en &
            "Un gran saludo desde Distribuidora UNLZ!" & en & en & en & en &
            "(Por favor no respondas a éste email, es automático... gracias!)" & en & en

        Dim ok As String = EnviarMail(email, "Distribuidora UNLZ - Clave Recuperada", mensaje)
        If ok = "OK" Then
            lReenviarClave.Text = "*** Ya te enviamos un mail con la clave! ***"
        Else
            lReenviarClave.Text = "*** Hubo un error al querer enviar el mail... ***"
        End If
        lReenviarClave.Visible = True
    End Sub

    Protected Sub bVolverLogin_Click(sender As Object, e As EventArgs) Handles bVolverLogin.Click
        pLogin.Visible = False
        pLoginMenu.Visible = True
    End Sub

    Protected Sub bEntrarAdmin_Click(sender As Object, e As EventArgs) Handles bEntrarAdmin.Click
        Session("QueEs") = "Administradores"
        Loguea()
    End Sub

    Protected Sub botonRegistrarse_Click(sender As Object, e As EventArgs) Handles botonRegistrarse.Click
        pLoginMenu.Visible = False
        pRegistrarse.Visible = True
    End Sub

    Protected Sub botonAlogin_Click(sender As Object, e As EventArgs) Handles botonAlogin.Click
        pLoginMenu.Visible = False
        pLogin.Visible = True
    End Sub

    Protected Sub botonRegistrarseVolverLoginU13_Click(sender As Object, e As EventArgs) Handles botonRegistrarseVolverLoginU13.Click
        pLoginMenu.Visible = False
        pPortada.Visible = True
    End Sub

    Protected Sub botonRegistrarseU_Click(sender As Object, e As EventArgs) Handles botonRegistrarseU.Click

        Dim ok As Boolean = True
        Dim ok3 As Boolean = True

        LimpiarErroresRegistroU()

        tNombreU.Text = tNombreU.Text.Trim.ToUpper
        If comprobar(tNombreU.Text) = False Then
            ArreglarCampo(tNombreU)
            ok = False
            lENombreU.Text = "El nombre contenía caracteres inválidos, fueron quitados."
            lENombreU.Visible = True
        End If
        tApellidoU.Text = tApellidoU.Text.Trim.ToUpper
        If comprobar(tApellidoU.Text) = False Then
            ArreglarCampo(tApellidoU)
            ok = False
            lEApellidoU.Text = "El apellido contenía caracteres inválidos, fueron quitados."
            lEApellidoU.Visible = True
        End If
        tDocU.Text = tDocU.Text.Trim
        If comprobar(tDocU.Text) = False Or Not IsNumeric(tDocU.Text) Then
            SoloNumeros(tDocU)
            ok = False
            lEDocU.Text = "El documento no era valido, se ajustó a número."
            lEDocU.Visible = True
        End If
        ArreglarCampo(tEmailU)
        If ValidateEmail(tEmailU.Text) = False Then
            ok = False
            lEEmailU.Text = "El email no es válido"
            lEEmailU.Visible = True
        End If

        tLocalidadU.Text = tLocalidadU.Text.Trim.ToUpper
        If comprobar(tLocalidadU.Text) = False Then
            ArreglarCampo(tLocalidadU)
            ok = False
            lELocalidadU.Text = "La localidad contenia caracteres inválidos, fueron quitados"
            lELocalidadU.Visible = True
        End If

        tDireccionU.Text = tDireccionU.Text.Trim.ToUpper
        If comprobar(tDireccionU.Text) = False Then
            ArreglarCampo(tDireccionU)
            ok = False
            lEDireccionU.Text = "La direccion contenia caracteres inválidos, fueron quitados"
            lEDireccionU.Visible = True
        End If

        tTelefonosU.Text = tTelefonosU.Text.Trim.ToUpper
        If comprobar(tTelefonosU.Text) = False Then
            ArreglarCampo(tTelefonosU)
            ok = False
            lETelefonosU.Text = "El telefono contenia caracteres inválidos, fueron quitados"
            lETelefonosU.Visible = True
        End If

        Dim FechaNacimiento As Date
        ControlDeNacimiento(tF_Nac, ok, lEFNac, lEdad, True, FechaNacimiento)

        tUsuarioU.Text = tUsuarioU.Text.Trim.ToUpper
        If comprobar(tUsuarioU.Text) = False Or tUsuarioU.Text.IndexOf(" ") > -1 Then
            tUsuarioU.Text = tUsuario.Text.Replace(" ", "")
            ArreglarCampo(tUsuarioU)
            ok = False
            lEUsuarioU.Text = "El usuario contenía caracteres inválidos, fueron quitados."
            lEUsuarioU.Visible = True
        End If
        If tUsuarioU.Text.Length < 5 Then
            ok = False
            lEUsuarioU.Text = "El usuario debe tener de 5 a 10 caracteres, letras y/o números."
            lEUsuarioU.Visible = True
        End If

        tPassU.Text = tPassU.Text.Trim
        If comprobar(tPassU.Text) = False Or tPassU.Text.IndexOf(" ") > -1 Then
            tPassU.Text = tPassU.Text.Replace(" ", "")
            ArreglarCampo(tPassU)
            ok = False
            lEPassU.Text = "La clave contenia caracteres inválidos. Pruebe con letras y números."
            lEPassU.Visible = True
        End If
        If tPassU.Text.Length < 5 Then
            ok = False
            lEPassU.Text = "La clave debe tener de 5 a 10 caracteres, letras y/o números."
            lEPassU.Visible = True
        End If

        tPass2U.Text = tPass2U.Text.Trim
        If comprobar(tPass2U.Text) = False Or tPass2U.Text.IndexOf(" ") > -1 Then
            tPass2U.Text = tPass2U.Text.Replace(" ", "")
            ArreglarCampo(tPass2U)
            ok = False
            lEPass2U.Text = "La segunda clave contenia caracteres inválidos. Pruebe con letras y números."
            lEPass2U.Visible = True
        End If

        If tPass2U.Text <> tPassU.Text Then
            ok = False
            lEPass2U.Text = "Las 2 claves son diferentes"
            lEPass2U.Visible = True
        End If

        If ok = False Then
            lErroresU.Text = "Revise los errores por favor y luego reintente."
            lErroresU.Visible = True
            Exit Sub
        End If

        Session("Usuario") = tUsuarioU.Text
        Session("Password") = tPassU.Text
        Session("TipoDocumento") = dTDocU.SelectedValue.Trim
        Session("Documento") = tDocU.Text.Trim

        If YaExisteSQL("select idusuario from usuarios where usuario='" & Session("Usuario") & "'") Then
            ok3 = False
            lEUsuarioU.Text = "El usuario elegido ya existe. Pruebe con otro."
            lEUsuarioU.Visible = True
        End If
        If YaExisteSQL("select idusuario from usuarios where doc='" & Session("Documento") _
                & "' and tdoc='" & Session("TipoDocumento") & "'") Then
            ok3 = False
            lEDocU.Text = "Ya existe el " & Session("TipoDocumento") & " " & Session("Documento") & "."
            lEDocU.Visible = True
        End If
        If YaExisteSQL("select idusuario from usuarios where Email='" & tEmailU.Text.Trim & "'") Then
            ok3 = False
            lEEmailU.Text = "Ya existe un usuario con ese email. Elija otro."
            lEEmailU.Visible = True
        End If

        If ok3 = False Then
            lErroresU.Text = "Solo se permite una inscripcion por persona."
            lErroresU.Visible = True
            Exit Sub
        End If

        Session("Usuario") = tUsuarioU.Text
        Session("Password") = tPassU.Text
        Session("TipoDocumento") = dTDocU.SelectedValue.Trim
        Session("Documento") = tDocU.Text.Trim
        Session("ApellidoYNombre") = tNombreU.Text.Trim & " " & tApellidoU.Text.Trim
        Session("Email") = tEmailU.Text.Trim

        LimpiarErroresRegistroU()

        Session("sqlIngreso") = "insert into Usuarios (Apellido,Nombre,tDoc,Doc,Usuario,Pass,Email,idProv,Localidad,Direccion,Telefonos,fNacimiento) values('" _
                & tApellidoU.Text.Trim & "','" & tNombreU.Text.Trim & "','" & Session("TipoDocumento") & "','" _
                & Session("Documento") & "','" & Session("Usuario") & "','" & Session("Password") & "','" _
                & Session("Email") & "'," & didProvU.SelectedValue & ",'" & tLocalidadU.Text.Trim & "','" _
                & tDireccionU.Text.Trim & "','" & tTelefonosU.Text.Trim & "','" & FechaNacimiento.ToString("yyyy-MM-dd") & "')"

        Dim codigo As String = CreaCodigo(4)
        Session("Codigo") = codigo
        Dim en As String = Chr(13) & Chr(10), mensaje As String = "Saludos " & Session("ApellidoYNombre") &
            "." & en & en & "Te escribimos desde Distribuidora UNLZ, en respuesta a tu solicitud de registro " &
            "como nuevo usuario de nuestra aplicación." & en & en &
            "Por favor, ingresá el codigo: " & codigo & " en el cuadro de texto de la aplicación web, y presioná Valida. " &
            "Esto completará tu registro como nuevo usuario de Distribuidora UNLZ " & en & en &
            "Felicitaciones " & en &
            "El equipo de Distribuidora UNLZ " & en & en & en & en &
            "(Mail automatizado, no responder)"

        Dim ok2 As String = EnviarMail(Session("Email"), "Distribuidora UNLZ - Registro de usuario", mensaje)
        tValidar.Text = ""
        lCodigo.Visible = False
        pRegistrarse.Visible = False
        pVerificaMail.Visible = True
        lCodigo.Text = ""
        lCodigo.Visible = False

    End Sub

    Protected Sub botonRegistrarseU0_Click(sender As Object, e As EventArgs) Handles botonRegistrarseU0.Click
        pLoginMenu.Visible = True
        pRegistrarse.Visible = False
    End Sub

    Protected Sub botonRegistrarseVolverLoginU_Click(sender As Object, e As EventArgs) Handles botonRegistrarseVolverLoginU.Click
        pBienvenido.Visible = False
        pLogin.Visible = True
    End Sub

    Protected Sub botonAhoraQueHago_Click(sender As Object, e As EventArgs) Handles botonAhoraQueHago.Click
        pAreaUsuario.Visible = False
        pAhoraQueHago.Visible = True
    End Sub

    Protected Sub botonHacerPedido_Click(sender As Object, e As EventArgs) Handles botonHacerPedido.Click
        pAreaUsuario.Visible = False
        pPedidos.Visible = True
    End Sub

    Protected Sub botonModificarDatos_Click(sender As Object, e As EventArgs) Handles botonModificarDatos.Click

        tCEmailU.Text = Session("Email")
        didCProvU.SelectedValue = Session("idProv")
        tCLocalidadU.Text = Session("Localidad")
        tCDireccionU.Text = Session("Direccion")
        tCTelefonosU.Text = Session("Telefonos")
        tCUsuarioU.Text = Session("Usuario")
        tCClaveU.Text = Session("Password")

        pAreaUsuario.Visible = False
        pCambiarDatosPersonales.Visible = True

    End Sub

    Protected Sub bAreaAdministrador_Click(sender As Object, e As EventArgs) Handles bAreaAdministrador.Click
        pAreaUsuario.Visible = False
        pAreaAdministrador.Visible = True
    End Sub

    Protected Sub botonVolverLoginU1_Click(sender As Object, e As EventArgs) Handles botonVolverLoginU1.Click
        LimpiarLogin()
        LimpiarRegistroU()
        lReenviarClave.Text = ""
        pLogin.Visible = True
        pAreaUsuario.Visible = False
        tUsuario.Text = Session("Usuario")
        tClave.Text = Session("Password")
    End Sub

    Protected Sub botonVolverLoginU2_Click(sender As Object, e As EventArgs) Handles botonVolverLoginU2.Click
        pAhoraQueHago.Visible = False
        pAreaUsuario.Visible = True
    End Sub

    Protected Sub botonCambiarDatos_Click(sender As Object, e As EventArgs) Handles botonCambiarDatos.Click

        Dim ok As Boolean = True

        LimpiarErroresCambios()

        ArreglarCampo(tCEmailU)
        If ValidateEmail(tCEmailU.Text) = False Then
            ok = False
            EEmailU.Text = "El Email no es válido."
            EEmailU.Visible = True
        End If


        tCLocalidadU.Text = tCLocalidadU.Text.Trim().ToUpper()
        If comprobar(tCLocalidadU.Text) = False Then
            ArreglarCampo(tCLocalidadU)
            ok = False
            ELocalidadU.Text = "La localidad contenía caracteres invalidos,fueron quitados"
            ELocalidadU.Visible = True
        End If


        tCDireccionU.Text = tCDireccionU.Text.Trim.ToUpper
        If comprobar(tCDireccionU.Text) = False Then
            ArreglarCampo(tCDireccionU)
            ok = False
            EDireccionU.Text = "La direccion contenia caracteres inválidos,fueron quitados"
            EDireccionU.Visible = True
        End If

        tCTelefonosU.Text = tCTelefonosU.Text.Trim.ToUpper
        If comprobar(tCTelefonosU.Text) = False Then
            ArreglarCampo(tCTelefonosU)
            ok = False
            ETelefonosU.Text = "El telefono contenia caracteres inválidos, fueron quitados"
            ETelefonosU.Visible = True
        End If


        tCUsuarioU.Text = tCUsuarioU.Text.Trim.ToUpper
        If comprobar(tCUsuarioU.Text) = False Or tCUsuarioU.Text.IndexOf(" ") > -1 Then
            tCUsuarioU.Text = tCUsuarioU.Text.Replace(" ", "")
            ArreglarCampo(tCUsuarioU)
            ok = False
            EUsuarioU.Text = "El usuario contenía caracteres inválidos, fueron quitados."
            EUsuarioU.Visible = True
        End If
        If tCUsuarioU.Text.Length < 5 Then
            ok = False
            EUsuarioU.Text = "El usuario debe tener de 5 a 10 caracteres,letras y/o números."
            EUsuarioU.Visible = True
        End If


        tCClaveU.Text = tCClaveU.Text.Trim
        If comprobar(tCClaveU.Text) = False Or tCClaveU.Text.IndexOf(" ") > -1 Then
            tCClaveU.Text = tCClaveU.Text.Replace(" ", "")
            ArreglarCampo(tCClaveU)
            ok = False
            EPassU.Text = "La clave contenia caracteres inválidos. Pruebe con letras y números."
            EPassU.Visible = True
        End If
        If tCClaveU.Text.Length < 5 Then
            ok = False
            EPassU.Text = "La clave debe tener de 5 a 10 caracteres, letras y/o números."
            EPassU.Visible = True
        End If


        If tCUsuarioU.Text = Session("Usuario") = False Then
            If YaExisteSQL("select idusuario from usuarios where usuario='" & tCUsuarioU.Text & "'") Then
                ok = False
                EUsuarioU.Text = "El usuario elegido ya existe, pruebe con otro."
                EUsuarioU.Visible = True
            End If
        End If


        If ok = False Then
            lErrorU.Text = "Revise los Errores y vuelva a intentar."
            lErrorU.Visible = True
            Exit Sub
        End If

        LimpiarErroresCambios()

        Session("Email") = tCEmailU.Text
        Session("idProv") = didCProvU.SelectedValue
        Session("Localidad") = tCLocalidadU.Text
        Session("Direccion") = tCDireccionU.Text
        Session("Telefonos") = tCTelefonosU.Text
        Session("Usuario") = tCUsuarioU.Text
        Session("Password") = tCClaveU.Text


        If SQL_Accion("UPDATE Usuarios SET Usuario ='" & Session("Usuario") & "', Pass ='" _
                                & Session("Password") & "', Email='" & Session("Email") & "', idProv=" _
                                & Session("idProv") & ", Localidad='" & Session("Localidad") & "', Direccion='" _
                                & Session("Direccion") & "', Telefonos='" & Session("Telefonos") &
                                "' WHERE idUsuario=" & Session("idUsuario")) = False Then

            lErrorU.Text = "Se ha producido un error al querer guardar tus datos..."
            lErrorU.Visible = True
            Exit Sub
        End If


        pCambiarDatosPersonales.Visible = False
        pCambiarDatosPersonalesU.Visible = True

    End Sub

    Protected Sub botonCancelarCambios_Click(sender As Object, e As EventArgs) Handles botonCancelarCambios.Click
        LimpiarErroresCambios()
        pCambiarDatosPersonales.Visible = False
        pAreaUsuario.Visible = True
    End Sub

    Protected Sub botonVolverAtuArea_Click(sender As Object, e As EventArgs) Handles botonVolverAtuArea.Click
        pCambiarDatosPersonalesU.Visible = False
        pAreaUsuario.Visible = True
    End Sub

    Protected Sub botonNuevoPedido_Click(sender As Object, e As EventArgs) Handles botonNuevoPedido.Click

        Dim en As String = "</br>"

        lInstrucciones.Text = "INSTRUCCIONES:" & en & "1) Elija el Producto que desea solicitar." & en &
            "2) Indique la cantidad que desea solicitar." & en & "3) Oprima el botón 'Agregar', el item y la cantidad se verán en la lista inferior." & en &
            "4) Revise el pedido y oprima 'Enviar el pedido' para terminar." & en &
            "Para anular un pedido debe ir a la sección de 'Historial de pedidos', pero solo se podran anular los que tengan un estado de 'Solicitado'."

        lInstrucciones.Visible = False
        bInstrucciones.Text = "Abrir instrucciones"

        pPedidos.Visible = False
        lCosaAgregar.Text = ""
        CargarProductos()

        botonQuitarTodos.Visible = False
        botonSolicitarPedido.Visible = False
        lErrorPedido.Text = ""
        'borro el temporal de pedidos para el cliente
        If IsNothing(Session("idUsuario")) Then
            pLogin.Visible = True
            Exit Sub
        End If
        SQL_Accion("delete Web_Pedidos_Temporal where Num_Cli=" & Session("idUsuario"))
        CargaTemporal()
        pNuevoPedido.Visible = True

    End Sub

    Protected Sub botonTodosLosPedidos_Click(sender As Object, e As EventArgs) Handles botonTodosLosPedidos.Click
        pPedidos.Visible = False
        pHistorico.Visible = True
        CargaHistorico()
    End Sub

    Protected Sub botonVolverMenuPedidos_Click(sender As Object, e As EventArgs) Handles botonVolverMenuPedidos.Click
        pPedidos.Visible = False
        pAreaUsuario.Visible = True
    End Sub

    Protected Sub botonAgregarALista_Click(sender As Object, e As EventArgs) Handles botonAgregarALista.Click

        Dim x As Integer = 0, c As String, numero As Integer = 0
        Dim Cosa As String = lCosaAgregar.Text.Trim
        If Cosa = "----------" Then Exit Sub

        Dim Cantidad As Integer = VNum(tCantidad.SelectedValue.ToString)

        If Cantidad <= 0 Then Exit Sub
        lErrorPedido.Text = ""

        'veo si ya esta el item en la lista
        Dim da2 As New SqlDataAdapter("select cantidad from web_pedidos_temporal where Num_Cli=" & Session("idUsuario") &
                                      " and ltrim(rtrim(item))='" & Cosa & "'", con)
        Dim ds2 As New DataSet
        da2.Fill(ds2, "dato")
        If ds2.Tables("dato").Rows.Count > 0 Then
            'ya estaba le leo la cantidad y reemplazo
            Cantidad += VNum(ds2.Tables("dato").Rows(0)("cantidad"))
            If SQL_Accion("update web_pedidos_temporal set cantidad=" & Cantidad & " where Num_Cli=" _
                          & Session("idUsuario") & " and ltrim(rtrim(item))='" & Cosa & "'") = False Then
                lErrorPedido.Text = "No se pudo modificar el item elegido. Intente más tarde"
                Exit Sub
            End If
        Else
            If SQL_Accion("insert into web_pedidos_temporal (num_cli, item, cantidad) values (" &
                          Session("idUsuario") & ", '" & Cosa & "', " & Cantidad & ")") = False Then
                lErrorPedido.Text = "No puedo agregar el item a la lista. Intente más tarde."
                Exit Sub
            End If
        End If
        tCantidad.SelectedIndex = 0
        CargaTemporal()

    End Sub

    Protected Sub botonQuitarTodos_Click(sender As Object, e As EventArgs) Handles botonQuitarTodos.Click

        If SQL_Accion("delete web_pedidos_temporal where num_cli=" & VNum(Session("idUsuario"))) = False Then
            lErrorPedido.Text = "No se pudo quitar todos los items de la lista. Intente más tarde"
            Exit Sub
        End If
        CargaTemporal()

    End Sub

    Protected Sub botonSolicitarPedido_Click(sender As Object, e As EventArgs) Handles botonSolicitarPedido.Click

        Dim idU As Integer = VNum(Session("idUsuario"))
        Dim npedido As Integer = 0, vItem As String = "", vTipo As String = "", vCantidad As Integer = 0, cosa As String
        Dim linea As String = "", en As String = Chr(13) & Chr(10)
        lErrorPedido.Text = ""

        If SQL_Accion("insert into web_pedidos (num_cli) values (" & Session("idUsuario") & ")") = True Then

            Dim da2 As New SqlDataAdapter("select top 1 npedido from web_pedidos where num_cli=" _
                                          & Session("idUsuario") & "order by npedido desc", con)
            Dim ds2 As New DataSet

            da2.Fill(ds2, "dato")
            If ds2.Tables("dato").Rows.Count > 0 Then
                npedido = ds2.Tables("dato").Rows(0)("npedido")
                'obtengo el numero que se le asigno y lo uso para crear detalles
                If SQL_Accion("INSERT INTO WEB_pedidos_detalle (Item, Cantidad, NPedido)" &
                              "SELECT WEB_Pedidos_Temporal.Item, WEB_Pedidos_Temporal.Cantidad," &
                              npedido & " AS Npedido FROM WEB_Pedidos_Temporal where num_cli=" & idU) = True Then
                    lPedidoCreado.Text = "El pedido N° " & npedido & ", fue creado correctamente."
                    pNuevoPedido.Visible = False
                    pPedidoCreado.Visible = True


                    Dim da3 As New SqlDataAdapter("SELECT Item, Cantidad FROM Web_pedidos_detalle WHERE npedido=" & npedido, con)
                    Dim ds3 As New DataSet
                    Dim pedido As String = "Pedido N°" & npedido & en & en
                    da3.Fill(ds3, "pedido")

                    For Each row As DataRow In ds3.Tables("pedido").Rows
                        pedido &= row("item") & " - x"
                        pedido &= row("cantidad")
                        pedido &= en
                    Next

                    pedido &= en & "Numero de Cliente: " & idU

                    EnviarMail("distribuidora.unlz@gmail.com", "Nuevo pedido", pedido)

                    If SQL_Accion("DELETE WEB_Pedidos_Temporal WHERE Num_Cli=" & idU) = False Then
                    End If
                Else
                    lErrorPedido.Text = "Hubo un error al intentar guardar el detalle del pedido N°" _
                        & npedido & ", que quedó vacío o con carga parcial. Anúlelo o Intente más tarde."
                    Exit Sub
                End If
                Exit Sub
            Else
                lErrorPedido.Text = "Hubo un error al intentar guardar el detalle del pedido " _
                    & npedido & ", que quedó vacío. Anúlelo o Intente más tarde."
                Exit Sub
            End If
        Else
            lErrorPedido.Text = "Hubo un error al intentar guardar el pedido. Intente más tarde."
        End If

    End Sub

    Protected Sub botonCancelarPedido_Click(sender As Object, e As EventArgs) Handles botonCancelarPedido.Click

        If SQL_Accion("delete Web_Pedidos_Temporal where Num_Cli=" & VNum(Session("idUsuario"))) = False Then
        End If

        pNuevoPedido.Visible = False
        pPedidos.Visible = True

    End Sub

    Protected Sub botonVolverPedidoCreado_Click(sender As Object, e As EventArgs) Handles botonVolverPedidoCreado.Click
        pPedidoCreado.Visible = False
        pPedidos.Visible = True
    End Sub

    Protected Sub botonVolverPedidoAnulado_Click(sender As Object, e As EventArgs) Handles botonVolverPedidoAnulado.Click
        CargaHistorico()
        pPedidoAnular.Visible = False
        pHistorico.Visible = True
    End Sub

    Protected Sub botonVolverDetallePedido_Click(sender As Object, e As EventArgs) Handles botonVolverDetallePedido.Click
        pVerUnPedido.Visible = False
        pHistorico.Visible = True
    End Sub

    Protected Sub bPedidosAfabrica_Click(sender As Object, e As EventArgs) Handles bPedidosAfabrica.Click
        pAreaAdministrador.Visible = False
        pPedidos.Visible = True
    End Sub

    Protected Sub bVerPedidos_Click(sender As Object, e As EventArgs) Handles bVerPedidos.Click
        CargarHistoricoAdmin()
    End Sub

    Protected Sub bGestionarUsuarios_Click(sender As Object, e As EventArgs) Handles bGestionarUsuarios.Click
        pAreaAdministrador.Visible = False
        pUsuarios.Visible = True
        CargarAdminUsuarios()
    End Sub

    Protected Sub bAgregarProducto_Click(sender As Object, e As EventArgs) Handles bAgregarProducto.Click
        pAreaAdministrador.Visible = False
        pNuevoProducto.Visible = True
    End Sub

    Protected Sub bCambiarProducto_Click(sender As Object, e As EventArgs) Handles bCambiarProducto.Click
        MostrarProductos()
        pAreaAdministrador.Visible = False
        pCambiarProducto.Visible = True
    End Sub

    Protected Sub bVolverAreaU_Click(sender As Object, e As EventArgs) Handles bVolverAreaU.Click
        pAreaAdministrador.Visible = False
        pAreaUsuario.Visible = True
    End Sub

    Protected Sub bAgregarProd_Click(sender As Object, e As EventArgs) Handles bAgregarProd.Click

        Dim ok As Boolean = True

        LimpiarErroresProductos()

        tNombreProducto.Text = tNombreProducto.Text.Trim.ToUpper
        If comprobar(tNombreProducto.Text) = False Then
            ArreglarCampo(tNombreProducto)
            ok = False
            lErrorNombre.Text = "El nombre contenía caracteres inválidos, fueron quitados."
            lErrorNombre.Visible = True
        End If

        SoloNumeros(tPrecioProducto)
        If String.IsNullOrEmpty(tPrecioProducto.Text) Then
            ok = False
            lErrorPrecio.Text = "Ingrese un valor."
            lErrorPrecio.Visible = True
        End If

        SoloNumeros(tStockProducto)
        If String.IsNullOrEmpty(tStockProducto.Text) Then
            ok = False
            lErrorStock.Text = "Ingrese un valor."
            lErrorStock.Visible = True
        End If

        If ok = False Then
            lErrorAgregarProducto.Text = "Revise los Errores y vuelva a intentar."
            lErrorAgregarProducto.Visible = True
            Exit Sub
        End If

        Dim precio As Double = Double.Parse(tPrecioProducto.Text)
        tPrecioProducto.Text = Double.Parse(tPrecioProducto.Text)

        If YaExisteSQL("select cod from web_productos where producto='" & tNombreProducto.Text.Trim & "'") Then
            ok = False
            lErrorNombre.Text = "Ya existe un producto con ese nombre."
            lErrorNombre.Visible = True
        End If

        If SQL_Accion("insert into web_productos (producto, stock, preciosiniva) values ('" & tNombreProducto.Text.Trim &
                      "', " & tStockProducto.Text & ", " & precio & ")") = False Then
            lErrorAgregarProducto.Text = ""
            lErrorAgregarProducto.Visible = True
            Exit Sub
        End If

        pNuevoProducto.Visible = False
        pAreaAdministrador.Visible = True
    End Sub

    Protected Sub bCancelarProducto_Click(sender As Object, e As EventArgs) Handles bCancelarProducto.Click
        pNuevoProducto.Visible = False
        pAreaAdministrador.Visible = True
    End Sub

    Protected Sub bCambiarProd_Click(sender As Object, e As EventArgs) Handles bCambiarProd.Click

        Dim ok As Boolean = True
        Dim cod As Integer = VNum(LeeUnCampo("Select top 1 cod from web_productos where producto='" & dCambiarProductos.Text & "'", "cod"))

        LimpiarErroresProductos()

        tCambiarNom.Text = tCambiarNom.Text.Trim.ToUpper
        If comprobar(tCambiarNom.Text) = False Then
            ArreglarCampo(tCambiarNom)
            ok = False
            lErrorCNombre.Text = "El nombre contenía caracteres inválidos o estaba vacío."
            lErrorCNombre.Visible = True
        End If

        SoloNumeros(tCambiarPrecio)
        If String.IsNullOrEmpty(tCambiarPrecio.Text) Then
            ok = False
            lErrorCPrecio.Text = "Ingrese un valor."
            lErrorCPrecio.Visible = True
        End If

        SoloNumeros(tCambiarStock)
        If String.IsNullOrEmpty(tCambiarStock.Text) Then
            ok = False
            lErrorCStock.Text = "Ingrese un valor."
            lErrorCStock.Visible = True
        End If

        Dim precio As Double = Double.Parse(tCambiarPrecio.Text)
        Dim nombre As String = dCambiarProductos.Text

        If tCambiarNom.Text <> nombre Then
            If YaExisteSQL("select cod from web_productos where producto='" & tCambiarNom.Text.Trim & "'") Then
                ok = False
                lErrorCNombre.Text = "Ya existe un producto con ese nombre."
                lErrorCNombre.Visible = True
                Exit Sub
            End If
        End If

        If ok = False Then
            lErrorCProducto.Text = "Revise los Errores y vuelva a intentar."
            lErrorCProducto.Visible = True
            Exit Sub
        End If

        If SQL_Accion("update web_productos set producto='" & tCambiarNom.Text.Trim & "', stock=" & tCambiarStock.Text & ", preciosiniva=" & precio & " where cod=" & cod) = False Then
            lErrorCProducto.Text = "Se ha producido un error al querer guardar tus datos..."
            lErrorCProducto.Visible = True
            Exit Sub
        End If
        pCambiarProducto.Visible = False
        pAreaAdministrador.Visible = True

    End Sub

    Protected Sub bVolverAreaAdmin_Click(sender As Object, e As EventArgs) Handles bVolverAreaAdmin.Click
        pCambiarProducto.Visible = False
        pAreaAdministrador.Visible = True
    End Sub

    Protected Sub botonHistoricoAdminActualizar_Click(sender As Object, e As EventArgs) Handles botonHistoricoAdminActualizar.Click
        CargarHistoricoAdmin()
    End Sub

    Protected Sub botonHistoricoAdminVolver_Click(sender As Object, e As EventArgs) Handles botonHistoricoAdminVolver.Click
        pTodoslospedidos.Visible = False
        pAreaAdministrador.Visible = True
    End Sub

    Protected Sub botonVolverVerpedidoAdmin_Click(sender As Object, e As EventArgs) Handles botonVolverVerpedidoAdmin.Click
        pVerPedidoAdmin.Visible = False
        pTodoslospedidos.Visible = True
    End Sub

    Protected Sub bEnviar_Click(sender As Object, e As EventArgs) Handles bEnviar.Click
        Dim npedido As Integer = Convert.ToInt32(lEditarNumeroPedido.Text)
        Dim da1 As New SqlDataAdapter("SELECT Estado FROM WEB_Pedidos WHERE NPedido=" & npedido, con)
        Dim ds1 As New DataSet

        da1.Fill(ds1, "histo")

        If ds1.Tables("histo").Rows.Count = 0 Then
            lErrorEditarPedido.Text = "No se pudo acceder al pedido."
            lErrorEditarPedido.Visible = True
            Exit Sub
        Else
            Dim estado As String = ds1.Tables("histo")(0)("Estado").ToString.Trim

            If estado = "Enviado" Then
                lErrorEditarPedido.Text = "El pedido ya figura como enviado."
                lErrorHistoricoAdmin.Visible = True
                Exit Sub
            ElseIf estado = "Anulado" Then
                lErrorEditarPedido.Text = "El pedido estaba anulado."
                lErrorEditarPedido.Visible = True
                Exit Sub
            End If

            lErrorHistoricoAdmin.Text = ""

            If SQL_Accion("UPDATE WEB_Pedidos SET Estado='Enviado' WHERE NPedido=" & npedido) = False Then
                lErrorEditarPedido.Text = "No se pudo cambiar el estado debido a algún error de conexión."
                lErrorEditarPedido.Visible = True
                Exit Sub
            Else
                CargarHistoricoAdmin()

                lErrorHistoricoAdmin.Text = "El estado del pedido N°" & npedido & " fue cambiado."
                lErrorHistoricoAdmin.Visible = True

                pEditarPedido.Visible = False
                pTodoslospedidos.Visible = True
                Exit Sub
            End If
        End If
    End Sub

    Protected Sub bVolver_Click(sender As Object, e As EventArgs) Handles bVolver.Click
        pEditarPedido.Visible = False
        pTodoslospedidos.Visible = True
    End Sub

    Protected Sub botonVolverPedidoAnuladoAdmin_Click(sender As Object, e As EventArgs) Handles botonVolverPedidoAnuladoAdmin.Click
        pPedidoAnuladoAdmin.Visible = False
        pTodoslospedidos.Visible = True
    End Sub

    Protected Sub bVolverResultadosUsuarios_Click(sender As Object, e As EventArgs) Handles bVolverResultadosUsuarios.Click
        pUsuarios.Visible = False
        pAreaAdministrador.Visible = True
    End Sub

    Protected Sub bEliminarUsuario_Click(sender As Object, e As EventArgs) Handles bEliminarUsuario.Click

        Dim id As String = lEliminarUsuarioNumero.Text
        Dim mensaje As String = tMensajeEliminar.Text

        If mensaje = "" Then
            lErrorEliminarUsuario.Text = "Ingrese un mensaje."
            lErrorEliminarUsuario.Visible = True
            Exit Sub
        End If

        Dim da1 As New SqlDataAdapter("SELECT Email FROM Usuarios WHERE idUsuario=" & id, con)
        Dim ds1 As New DataSet

        da1.Fill(ds1, "dato")

        If ds1.Tables("dato").Rows.Count = 0 Then
            lErrorGestionUsuario.Text = "Se produjo un error"
            lErrorGestionUsuario.Visible = True
            pUsuarios.Visible = True
            pEliminarUsuario.Visible = False
            Exit Sub
        End If
        Dim email As String = ds1.Tables("dato")(0)("email").ToString.Trim


        If SQL_Accion("DELETE Usuarios WHERE idUsuario=" & id) = False Then
            lErrorGestionUsuario.Text = "Se produjo un error al eliminar al usuario."
            lErrorGestionUsuario.Visible = True
            pUsuarios.Visible = True
            pEliminarUsuario.Visible = False
        Else
            lConfirmacionDeCambio.Text = "El usuario ha sido eliminado."
            lConfirmacionDeCambio.Visible = True

            EnviarMail(email, "Distribuidora - Su usuario a sido eliminado.", mensaje)

            pConfirmacionDeCambio.Visible = True
            pEliminarUsuario.Visible = False
        End If
    End Sub

    Protected Sub bCancelarEliminarUsuario_Click(sender As Object, e As EventArgs) Handles bCancelarEliminarUsuario.Click
        pEliminarUsuario.Visible = False
        pUsuarios.Visible = True
    End Sub

    Protected Sub bVolverConfirmacionDeCambio_Click(sender As Object, e As EventArgs) Handles bVolverConfirmacionDeCambio.Click
        pConfirmacionDeCambio.Visible = False
        pAreaAdministrador.Visible = True
    End Sub

    Protected Sub bBloquearUsuario_Click(sender As Object, e As EventArgs) Handles bBloquearUsuario.Click

        Dim id As String = lBloquearUsuarioNumero.Text
        Dim mensaje As String = tMensajeBloqueo.Text

        If mensaje = "" Then
            lErrorBloquearUsuario.Text = "Debe ingresar un mensaje"
            lErrorBloquearUsuario.Visible = True
            Exit Sub
        End If

        Dim da1 As New SqlDataAdapter("SELECT Email FROM Usuarios WHERE idUsuario=" & id, con)
        Dim ds1 As New DataSet

        da1.Fill(ds1, "dato")

        If ds1.Tables("dato").Rows.Count = 0 Then
            lErrorGestionUsuario.Text = "Se produjo un error"
            lErrorGestionUsuario.Visible = True
            pUsuarios.Visible = True
            pBloquearUsuario.Visible = False
            Exit Sub
        End If
        Dim email As String = ds1.Tables("dato")(0)("email").ToString.Trim

        If SQL_Accion("UPDATE Usuarios SET Estado='Bloqueado' WHERE idUsuario=" & id) = False Then
            lErrorGestionUsuario.Text = "Se produjo un error al bloquear al usuario."
            lErrorGestionUsuario.Visible = True
            pUsuarios.Visible = True
            pBloquearUsuario.Visible = False
            Exit Sub
        Else
            lConfirmacionDeCambio.Text = "El usuario ha sido bloqueado."
            lConfirmacionDeCambio.Visible = True

            EnviarMail(email, "Distribuidora - Su usuario a sido bloqueado", mensaje)

            pConfirmacionDeCambio.Visible = True
            pBloquearUsuario.Visible = False
        End If

    End Sub

    Protected Sub bCancelarBloqueo_Click(sender As Object, e As EventArgs) Handles bCancelarBloqueo.Click
        pBloquearUsuario.Visible = False
        pUsuarios.Visible = True
    End Sub

    Protected Sub bValidar_Click(sender As Object, e As EventArgs) Handles bValidar.Click

        pVerificaMail.Visible = False
        Dim sqlIngreso As String = Session("sqlIngreso") & " "

        If sqlIngreso.Length < 10 Or sqlIngreso.IndexOf("insert") < 0 Then
            lErroresU.Text = "Hubo un error con el código. Trate de generar uno nuevo."
            lErroresU.Visible = True
            pRegistrarse.Visible = True
            Exit Sub
        End If

        If tValidar.Text.Trim.ToUpper <> Session("codigo") Then
            lCodigo.Visible = True
            pVerificaMail.Visible = True
            Exit Sub
        End If

        If SQL_Accion(sqlIngreso) = False Then
            lErroresU.Text = "Hubo un error al validar la cuenta. Trate de generar un nuevo código."
            lErroresU.Visible = True
            pRegistrarse.Visible = True
        End If

        Session("idUsuario") = VNum(LeeUnCampo("SELECT TOP 1 idUsuario FROM Usuarios WHERE Usuario ='" &
                                               Session("Usuario") & "' and Pass = '" & Session("Password") &
                                               "' ", "idUsuario"))

        lBienvenido.Text = "Bienvenido/a " & Session("ApellidoYNombre")

        lMensaje.Text = "Ya tenés tu cuenta de Distribuidora UNLZ, tu nombre de usuario es " & """" & Session("Usuario") & """"

        LimpiarRegistroU()

        pVerificaMail.Visible = False
        pBienvenido.Visible = True
        botonRegistrarseVolverLoginU.Focus()

    End Sub

    Protected Sub bRegresarRegistro_Click(sender As Object, e As EventArgs) Handles bRegresarRegistro.Click
        pVerificaMail.Visible = False
        tValidar.Text = ""
        pRegistrarse.Visible = True
    End Sub

    Protected Sub bCancelarValidar_Click(sender As Object, e As EventArgs) Handles bCancelarValidar.Click
        pVerificaMail.Visible = False
        tValidar.Text = ""
        pLoginMenu.Visible = True
    End Sub
End Class