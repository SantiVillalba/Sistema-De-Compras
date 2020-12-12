<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Sistema._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"/>
    <title>Sistema</title>
    <style type="text/css">
        #form1 {
            width: 767px;
            height: 886px;
            margin: auto auto;
            margin-top: auto;
            margin-bottom: auto;
        }
    </style>
</head>
<body bgcolor="#ffffff">
    <form id="form1" runat="server">
        <asp:Panel ID="pPortada" runat="server" ForeColor="Blue"  Height="350px" Width="765px">
            <asp:ImageButton ID="bPortada" runat="server" ImageAlign="Middle" ImageUrl="~/imagenes/panelinicial.jpg" Height="350px" width="765px"/>
        </asp:Panel>

        <asp:Panel ID="pLogin" runat="server" ForeColor="#372C57" Font-Bold="true" Width="765px" Font-Size="Large" Visible="false">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <asp:Label ID="lVersion" runat="server" Font-Bold="true" Font-Size="Large" ForeColor="#999999" Text="Versión"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="Label104" runat="server" Font-Bold="true" Font-Size="X-Large"
                            Text="Ingresá tu Usuario y Clave, y oprimí ENTRAR!"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lUsuario" runat="server"  Font-Size="XX-Large" Font-Bold="true" Text="Usuario:"></asp:Label>
                        <asp:TextBox ID="tUsuario" runat="server" CssClass="form-control" MaxLength="10" Width="350px"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lClave" runat="server" Font-Bold="true" Font-Size="XX-Large" Text="Clave:"></asp:Label>
                        <asp:TextBox ID="tClave" runat="server" CssClass="form-control" MaxLength="10" TextMode="Password" Width="350px"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bEntrar" runat="server" CssClass="btn btn-outline-primary" Text="Entrar!" Font-Size="X-Large" Width="250px" Height="54px" />
                        
                    </td>
                </tr>
            </table>
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bEntrarAdmin" runat="server" CssClass="btn btn-outline-primary" Text="Entrar como Administrador" Width="250px" Height="54px" />
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lErrorLogin" runat="server" ForeColor="Red" Visible="false" Text="IErrorLogin"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h3>Olvidaste tu clave?: Ingresa tu<br /> usuario, y te la mandamos al mail</h3>
                    </td>
                    <td>
                        <asp:Button ID="botonRecuperarClave" runat="server" CssClass="btn btn-outline-primary" Text="Reenviar Clave" Font-Size="X-Large" />
                    </td>
                    <td>
                        <asp:Label ID="lReenviarClave" runat="server" Text="[lReenviarClave]" Visible="false" ></asp:Label>
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bVolverLogin" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Font-Size="X-Large" Width="250px" Height="54px" />
                    </td>
                </tr>
            </table>
            <br />
        </asp:Panel>

        <asp:Panel ID="pLoginMenu" runat="server" Font-Bold="True" Width="757px" Font-Size="Large" ForeColor="#372C57" Visible="false">
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label runat="server" Font-Size="XX-Large" Text="Registrate o Ingresá."></asp:Label>
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Label runat="server" Font-Size="X-Large" Text="Registrate en nuestra Tienda Online" ></asp:Label>&nbsp&nbsp&nbsp&nbsp
                    </td>
                    <td align="center">
                        <asp:Button ID="botonRegistrarse" runat="server" CssClass="btn btn-outline-primary" Width="278px" Height="58px" Text="Registrarse Aquí" />
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Label runat="server" Font-Size="X-Large" Text="Si ya estás Registrado" ></asp:Label>&nbsp&nbsp&nbsp&nbsp
                    </td>
                    <td align="center">
                        <asp:Button ID="botonAlogin" runat="server" CssClass="btn btn-outline-primary" Width="278px" Height="58px" Text="Entra por aquí" />
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonRegistrarseVolverLoginU13" runat="server" CssClass="btn btn-outline-danger" Width="178px" Height="58px" Text="Volver" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pRegistrarse" runat="server" Visible="false"
            ForeColor="#372C57" Style="margin-right: 0px" Font-Size="Large">
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label runat="server" Font-Size="X-Large" Text="Registrarse en Nuestra Tienda Online" ></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <table>
                <tr>
                    <td>Para poder registrarte debés ser mayor de 18 años, residir en Argentina y contar con documento válido en
                        Argentina que acredite tu identidad.
                        <br />
                        Sólo se puede hacer un registro por documento. Los datos deben ser reales, correctos y vigentes.<br />
                        Todos los datos a continuación (menos Origen) son obligatorios:
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width: 100%;">
                <tr>
                    <td>Tu/s Nombre/s:</td>
                    <td>
                        <asp:TextBox ID="tNombreU" runat="server" CssClass="form-control" MaxLength="20" Font-Size="X-Large" ></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lENombreU" runat="server" Text="lENombreU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Apellido/s:</td>
                    <td>
                        <asp:TextBox ID="tApellidoU" runat="server" CssClass="form-control" MaxLength="20" Font-Size="X-Large"></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lEApellidoU" runat="server" Text="lEApellidoU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Tipo Doc.:</td>
                    <td>
                        <asp:DropDownList ID="dTDocU" runat="server" CssClass="btn btn-primary dropdown-toggle" Font-Size="X-Large" Width="350px">
                            <asp:ListItem Value="DNI">Doc. Nacional de Identidad</asp:ListItem>
                            <asp:ListItem Value="LC">Libreta Cívica</asp:ListItem>
                            <asp:ListItem Value="LE">Libreta de Enrolamiento</asp:ListItem>
                        </asp:DropDownList></td>
                    <td></td>
                </tr>
                <tr>
                    <td>N° de Doc. (sin puntos ni espacios):</td>
                    <td>
                        <asp:TextBox ID="tDocU" runat="server" CssClass="form-control" MaxLength="8" Font-Size="X-Large" ></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lEDocU" runat="server" Text="lEDocU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Fecha Nac.:(ddmmaa)</td>
                    <td>
                        <asp:TextBox ID="tF_Nac" runat="server" CssClass="form-control" MaxLength="6" Font-Size="X-Large" ></asp:TextBox>
                        <asp:Label ID="lEdad" runat="server" Text="0"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lEFNac" runat="server" Text="lEFNac" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Email válido para notificaciones:</td>
                    <td>
                        <asp:TextBox ID="tEmailU" runat="server" CssClass="form-control" MaxLength="70" Rows="2" TextMode="MultiLine" Font-Size="X-Large" ></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lEEmailU" runat="server" Text="lEEmailU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Provincia:</td>
                    <td>
                        <asp:DropDownList ID="didProvU" runat="server" CssClass="btn btn-primary dropdown-toggle" Font-Size="X-Large" Width="350px">
                            <asp:ListItem Value="1">Buenos Aires</asp:ListItem>
                            <asp:ListItem Value="2">Catamarca</asp:ListItem>
                            <asp:ListItem Value="3">Chaco</asp:ListItem>
                            <asp:ListItem Value="4">Chubut</asp:ListItem>
                            <asp:ListItem Value="5">CABA</asp:ListItem>
                            <asp:ListItem Value="6">Córdoba</asp:ListItem>
                            <asp:ListItem Value="7">Corrientes</asp:ListItem>
                            <asp:ListItem Value="8">Entre Ríos</asp:ListItem>
                            <asp:ListItem Value="9">Formosa</asp:ListItem>
                            <asp:ListItem Value="10">Jujuy</asp:ListItem>
                            <asp:ListItem Value="11">La Pampa</asp:ListItem>
                            <asp:ListItem Value="12">La Rioja</asp:ListItem>
                            <asp:ListItem Value="13">Mendoza</asp:ListItem>
                            <asp:ListItem Value="14">Misiones</asp:ListItem>
                            <asp:ListItem Value="15">Neuquén</asp:ListItem>
                            <asp:ListItem Value="16">Río Negro</asp:ListItem>
                            <asp:ListItem Value="17">Salta</asp:ListItem>
                            <asp:ListItem Value="18">San Juan</asp:ListItem>
                            <asp:ListItem Value="19">San Luis</asp:ListItem>
                            <asp:ListItem Value="20">Santa Cruz</asp:ListItem>
                            <asp:ListItem Value="21">Santa Fe</asp:ListItem>
                            <asp:ListItem Value="22">Santiago del Estero</asp:ListItem>
                            <asp:ListItem Value="23">Tucumán</asp:ListItem>
                            <asp:ListItem Value="24">Tierra del Fuego</asp:ListItem>
                        </asp:DropDownList></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Localidad:</td>
                    <td>
                        <asp:TextBox ID="tLocalidadU" runat="server" CssClass="form-control" MaxLenght="25" Font-Size="X-Large" ></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lELocalidadU" runat="server" Text="lELocalidadU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Direccion:</td>
                    <td>
                        <asp:TextBox ID="tDireccionU" runat="server" CssClass="form-control" MaxLength="100" Font-Size="Large"></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lEDireccionU" runat="server" Text="lEDireccionU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Teléfono (agregue característica):</td>
                    <td>
                        <asp:TextBox ID="tTelefonosU" runat="server" CssClass="form-control" MaxLength="25" Font-Size="X-Large" ></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lETelefonosU" runat="server" Text="lETelefonosU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Usuario:</td>
                    <td>
                        <asp:TextBox ID="tUsuarioU" runat="server" CssClass="form-control" MaxLength="10" Font-Size="X-Large" ></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lEUsuarioU" runat="server" Text="lEUsuarioU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Clave:</td>
                    <td>
                        <asp:TextBox ID="tPassU" runat="server" CssClass="form-control" MaxLength="10" TextMode="Password" Font-Size="X-Large" ></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lEPassU" runat="server" Text="lEPassU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Repetir Clave:</td>
                    <td>
                        <asp:TextBox ID="tPass2U" runat="server" CssClass="form-control" MaxLength="10" TextMode="Password" Font-Size="X-Large" ></asp:TextBox></td>
                    <td>
                        <asp:Label ID="lEPass2U" runat="server" Text="lEPass2U" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td>
                        <asp:Label ID="lErroresU" runat="server" Text="lErroresU" ForeColor="Red" Visible="false" /></td>
                </tr>
            </table>
            <br /><br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonRegistrarseU" runat="server" CssClass="btn btn-outline-primary" Text="Registrarse" Height="60px" Width="250px" />
                    </td>
                    <td align="center">
                        <asp:Button ID="botonRegistrarseU0" runat="server" CssClass="btn btn-outline-warning" Text="Cancelar y Volver" Height="60px" Width="250px" />
                    </td>
                </tr>
            </table>
            <br /><br />
        </asp:Panel>

        <asp:Panel ID="pBienvenido" runat="server" Height="535px" ForeColor="#372C57" Font-Size="Large" Visible="false">
            <br />
            <br />
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <h1>
                            <asp:Label ID="lBienvenido" runat="server" Text="Bienvenido/a !!" /></h1>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lMensaje" runat="server" Text="Bienvenido"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonRegistrarseVolverLoginU" runat="server" CssClass="btn btn-outline-primary" Text="Todo ok! Volver a Login" Width="378px" Height="58px" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pAreaUsuario" runat="server" Visible="false" ForeColor="#372C57" Font-Size="Large">

            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <h1>
                            <asp:Label ID="lBienvenidoAreaU" runat="server" Text="Bienvenido/a !!"></asp:Label></h1>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonAhoraQueHago" runat="server" CssClass="btn btn-outline-primary" Text="Ayuda" Width="378px" Height="58px" />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        Desde acá vas a poder hacer varias cosas relacionadas con tu cuenta.
                    </td>
                </tr>
            </table>
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonHacerPedido" runat="server" CssClass="btn btn-outline-primary" Text="Hacer Pedido" Width="378px" Height="58px" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonModificarDatos" runat="server" CssClass="btn btn-outline-primary" Text="Modificar tus datos personales" Width="378px" Height="58px" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bAreaAdministrador" runat="server" CssClass="btn btn-outline-primary" Text="Area Administrador" Width="378px" Height="58px" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonVolverLoginU1" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Width="378px" Height="58px" />
                    </td>
                </tr>
            </table>
            <br /><br />
        </asp:Panel>

        <asp:Panel ID="pAhoraQueHago" runat="server" ForeColor="#372C57" Font-Size="Large" Visible="false">
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <h1>Te cuento un poco!</h1>
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width: 100%;">
                <tr>
                    <td>
                        En la actualidad, hemos desarrollado nuestra Tienda Online alcanzando al Consumidor Final y atendiendo al canal minorista.
                        Mediante la tienda Online podemos brindarle a nuestros clientes una nueva y más cómoda manera de abastecerse. Permitiéndole comprar, desde 
                        su casa, a un precio diferencial y contando con todos los medios de pago disponibles.<br />
                        Comercializamos todo lo necesario para el desarrollo de los negocios gastronómicos, supermercados, tiendas y kioscos de nuestros clientes.
                        Restaurantes, cafeterías, panaderías y servicios de catering hacen sus compras recibiendo los pedidos en sus domicilios comerciales optimizando 
                        su tiempo y adquiriendo muy buenos precios.<br />
                        Productos comestibles, bebidas, golosinas y mucho más! 
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonVolverLoginU2" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Width="278px" Height="58px" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pCambiarDatosPersonales" runat="server" ForeColor="#372C57" Font-Size="Large" Visible="false">
            <table style="width: 100%;">
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td align="center">
                        <h2>Cambiar tus datos personales</h2>
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </table>

            <table style="width: 100%;">
                <tr>
                    <td>Email válido para notificaciones: </td>
                    <td>
                        <asp:TextBox ID="tCEmailU" runat="server" CssClass="form-control" MaxLength="70" Rows="2" TextMode="MultiLine" Font-Size="X-Large"></asp:TextBox></td>
                    <td>
                        <asp:Label ID="EEmailU" runat="server" Text="EEmailU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Provincia:</td>
                    <td>
                        <asp:DropDownList ID="didCProvU" runat="server" CssClass="btn btn-primary dropdown-toggle" Font-Size="X-Large" Width="350px">
                            <asp:ListItem Value="1">Buenos Aires</asp:ListItem>
                            <asp:ListItem Value="2">Catamarca</asp:ListItem>
                            <asp:ListItem Value="3">Chaco</asp:ListItem>
                            <asp:ListItem Value="4">Chubut</asp:ListItem>
                            <asp:ListItem Value="5">CABA</asp:ListItem>
                            <asp:ListItem Value="6">Córdoba</asp:ListItem>
                            <asp:ListItem Value="7">Corrientes</asp:ListItem>
                            <asp:ListItem Value="8">Entre Ríos</asp:ListItem>
                            <asp:ListItem Value="9">Formosa</asp:ListItem>
                            <asp:ListItem Value="10">Jujuy</asp:ListItem>
                            <asp:ListItem Value="11">La Pampa</asp:ListItem>
                            <asp:ListItem Value="12">La Rioja</asp:ListItem>
                            <asp:ListItem Value="13">Mendoza</asp:ListItem>
                            <asp:ListItem Value="14">Misiones</asp:ListItem>
                            <asp:ListItem Value="15">Neuquén</asp:ListItem>
                            <asp:ListItem Value="16">Río Negro</asp:ListItem>
                            <asp:ListItem Value="17">Salta</asp:ListItem>
                            <asp:ListItem Value="18">San Juan</asp:ListItem>
                            <asp:ListItem Value="19">San Luis</asp:ListItem>
                            <asp:ListItem Value="20">Santa Cruz</asp:ListItem>
                            <asp:ListItem Value="21">Santa Fe</asp:ListItem>
                            <asp:ListItem Value="22">Santiago del Estero</asp:ListItem>
                            <asp:ListItem Value="23">Tucumán</asp:ListItem>
                            <asp:ListItem Value="24">Tierra del Fuego</asp:ListItem>
                        </asp:DropDownList></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Localidad:</td>
                    <td>
                        <asp:TextBox ID="tCLocalidadU" runat="server" CssClass="form-control" MaxLenght="25" Font-Size="X-Large"></asp:TextBox></td>
                    <td>
                        <asp:Label ID="ELocalidadU" runat="server" Text="ELocalidadU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Direccion:</td>
                    <td>
                        <asp:TextBox ID="tCDireccionU" runat="server" CssClass="form-control" MaxLength="100" Rows="2" TextMode="MultiLine" Font-Size="Large"></asp:TextBox></td>
                    <td>
                        <asp:Label ID="EDireccionU" runat="server" Text="EDireccionU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Teléfono (agregue característica):</td>
                    <td>
                        <asp:TextBox ID="tCTelefonosU" runat="server" CssClass="form-control" MaxLength="25" Font-Size="X-Large"></asp:TextBox></td>
                    <td>
                        <asp:Label ID="ETelefonosU" runat="server" Text="ETelefonosU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Usuario:</td>
                    <td>
                        <asp:TextBox ID="tCUsuarioU" runat="server" CssClass="form-control" MaxLength="10" Font-Size="X-Large"></asp:TextBox></td>
                    <td>
                        <asp:Label ID="EUsuarioU" runat="server" Text="EUsuarioU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
                <tr>
                    <td>Clave:</td>
                    <td>
                        <asp:TextBox ID="tCClaveU" runat="server" CssClass="form-control" MaxLength="10" TextMode="Password" Font-Size="X-Large"></asp:TextBox></td>
                    <td>
                        <asp:Label ID="EPassU" runat="server" Text="EPassU" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
            </table>

            <table style="width: 100%;">
                <tr align="center">
                    <td>
                        <asp:Label ID="lErrorU" runat="server" Text="Error" ForeColor="Red" Visible="false"></asp:Label></td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonCambiarDatos" runat="server" CssClass="btn btn-outline-primary" Text="Cambiar datos" Height="60px" Width="250px" />&nbsp&nbsp&nbsp&nbsp
                        <asp:Button ID="botonCancelarCambios" runat="server" CssClass="btn btn-outline-warning" Text="Cancelar y Volver" Height="60px" Width="250px" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pCambiarDatosPersonalesU" runat="server" ForeColor="#372C57" BackImageUrl="~/Imagen/datospersonales.jpg" Font-Bold="true" Visible="false">
            <br /><br /><br /><br />
            <table style="width: 100%;">
                <tr align="center">
                    <td>
                        <h2>Tus datos han sido cambiados correctamente</h2>
                    </td>
                </tr>
            </table>
            <br /><br /><br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonVolverAtuArea" runat="server" CssClass="btn btn-outline-danger" Text="Volver a tu aréa" Font-Size="X-Large" Width="400px" />
                    </td>
                </tr>
            </table>
            <br /><br /><br />
        </asp:Panel>

        <asp:Panel ID="pPedidos" runat="server" Font-Bold="true" ForeColor="#372C57" Visible="false">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <br />
                        <h1>Menú de Pedidos</h1>
                        <br />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="botonNuevoPedido" runat="server" CssClass="btn btn-outline-primary" Text="Nuevo Pedido" Font-Size="X-Large" Width="350px" />
                    </td>
                    <td></td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="botonTodosLosPedidos" runat="server" CssClass="btn btn-outline-primary" Text="Todos los pedidos" Font-Size="X-Large" Width="350px" />
                    </td>
                    <td></td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="botonVolverMenuPedidos" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Font-Size="X-Large" Width="350px" />
                    </td>
                    <td></td>
                </tr>
            </table>
            <br />
        </asp:Panel>

        <asp:Panel ID="pNuevoPedido" runat="server" ForeColor="#372C57" Visible="false">
            <br />
            <h2>Nuevo Pedido a Fábrica</h2>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                        <asp:Button ID="bInstrucciones" runat="server" CssClass="btn btn-primary" Text="Abrir Instrucciones" />
                        <asp:Label ID="lInstrucciones" runat="server" Text="Instrucciones"></asp:Label>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td>
                        <h3>Seleccione el Producto</h3>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp
                        <asp:DropDownList ID="dProducto" runat="server" CssClass="btn btn-primary dropdown-toggle" Width="730px" AutoPostBack="True"></asp:DropDownList>
                    </td>
                </tr>

            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td class="auto-style1"></td>
                    <td>Agregar:
                    </td>
                    <td>
                        <asp:Label ID="lCosaAgregar" runat="server" Text="LABEL"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lQueEs" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1"></td>
                    <td>
                        <h3>Cantidad de Productos:</h3>
                    </td>
                    <td>
                        <asp:DropDownList ID="tCantidad" runat="server" CssClass="btn btn-primary dropdown-toggle">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td align="center">
                        <asp:Button ID="botonAgregarALista" runat="server" CssClass="btn btn-success" Text="Agregar" Height="60px" Width="150px" />
                    </td>
                </tr>
            </table>

            <table style="width: 100%;">
                <tr>
                    <td>Esta es la lista de su pedido.
                        <br />
                        <asp:GridView ID="gListaPedido" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="730px">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:ButtonField ButtonType="Image" CommandName="Quitar" ImageUrl="~/imagenes/quitar.png" Text="Quitar" />
                                <asp:BoundField DataField="Item" HeaderText="Item Solicitado" />
                                <asp:BoundField DataField="Cantidad" HeaderText="Cant" />
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="Gray" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="botonQuitarTodos" runat="server" CssClass="btn btn-danger" Text="Quitar Todos" Height="60px" Width="150px" />
                    </td>
                    <td align="center">
                        <asp:Button ID="botonSolicitarPedido" runat="server" CssClass="btn btn-success" Text="Enviar!" Height="60px" Width="150px" />
                    </td>
                    <td align="center">
                        <asp:Button ID="botonCancelarPedido" runat="server" CssClass="btn btn-danger" Text="Cancelar" Height="60px" Width="150px" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="lErrorPedido" runat="server" Text="lErrorPedido" ForeColor="Red" Visible="false"></asp:Label>
            <br />
            <br />
        </asp:Panel>

        <asp:Panel ID="pPedidoCreado" runat="server" ForeColor="#372C57" Visible="false">
            <br /><br /><br /><br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lPedidoCreado" runat="server" Text="El pedido fue CREADO." Font-Size="X-Large"></asp:Label>
                    </td>
                </tr>
            </table>
            <br /><br /><br /><br />
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="botonVolverPedidoCreado" runat="server" CssClass="btn btn-outline-danger" Width="350px" Text="Volver" Font-Size="X-Large" />
                    </td>
                </tr>
            </table>
            <br /><br /><br />
        </asp:Panel>

        <asp:Panel ID="pPedidoAnular" runat="server" ForeColor="#372C57" Visible="false">
            <br /><br /><br /><br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lPedidoAnulado" runat="server" Text="El pedido fue ANULADO" Font-Size="X-Large" Visible="false"></asp:Label>
                    </td>
                </tr>
            </table>
            <br /><br /><br /><br />
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="botonVolverPedidoAnulado" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Font-Size="X-Large" Width="350px" />
                    </td>
                </tr>
            </table>
            <br /><br /><br />
        </asp:Panel>

        <asp:Panel ID="pHistorico" runat="server" ForeColor="#372C57" Visible="false">
            <br />
            <h2>Histórico de pedidos y Revisar Estado</h2>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lErrorHistorico" runat="server" Text="lErrorHistorico" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="gHistorico" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="750px">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:ButtonField ButtonType="Button" ControlStyle-CssClass="btn btn-success" CommandName="Ver" Text="Ver Pedido" />
                    <asp:ButtonField ButtonType="Button" ControlStyle-CssClass="btn btn-danger" CommandName="Anular" HeaderText="(sólo &quot;Solicitado&quot;)" Text="Anular Pedido" ControlStyle-BackColor="Red" />
                    <asp:BoundField DataField="NPedido" HeaderText="N° Pedido" ReadOnly="True" />
                    <asp:BoundField DataField="fecha" DataFormatString="{0:dd/MM/yyyy HH:mm:tt}" HeaderText="Fecha y Hora" ReadOnly="True" />
                    <asp:BoundField DataField="estado" HeaderText="Estado del Pedido" />
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="Gray" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="Button8" runat="server" CssClass="btn btn-outline-success" text="Actualizar" Height="60px" Width="250px" />
                    </td>
                    <td align="center">
                        <asp:Button ID="bTerminarHistorico" runat="server" CssClass="btn btn-danger" Text="Terminar y Volver" Height="60px" Width="250px" />
                    </td>
                    <td></td>
                </tr>
            </table>
            <br />
            <br />
            <br />
        </asp:Panel>

        <asp:Panel ID="pVerUnPedido" runat="server" ForeColor="#372C57" Visible="false">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <h2>Detalle del Pedido N°
                            <asp:Label ID="Label3" runat="server"></asp:Label></h2>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:GridView ID="gVerUnPedido" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" CssClass="auto-style1" Width="600px">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:BoundField DataField="Item" HeaderText="Item Solicitado" />
                                <asp:BoundField DataField="Cantidad" HeaderText="Cant." />
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Label ID="lErrorVerUnPedido" runat="server" Text="lErrorVerUnPedido" ForeColor="Red" Visible="false"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="botonVolverDetallePedido" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Font-Size="X-Large" Width="300px" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pAreaAdministrador" runat="server" ForeColor="#372C57" Visible="false">
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <h1>Area de Administrador.</h1>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bPedidosAfabrica" runat="server" CssClass="btn btn-outline-primary" Font-Size="X-Large" Width="400px" Text="Hacer Pedido a fábrica" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bVerPedidos" runat="server" CssClass="btn btn-outline-primary" Font-Size="X-Large" Width="400px" Text="Pedidos de todos los usuarios." />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bGestionarUsuarios" runat="server" CssClass="btn btn-outline-primary" Font-Size="X-Large" Width="400px" Text="Gestionar Usuarios" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bAgregarProducto" runat="server" CssClass="btn btn-outline-primary" Font-Size="X-Large" Width="400px" Text="Agregar Productos" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bCambiarProducto" runat="server" CssClass="btn btn-outline-primary" Font-Size="X-Large" Width="400px" Text="Modificar Productos" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bVolverAreaU" runat="server" CssClass="btn btn-outline-danger" Font-Size="X-Large" Width="400px" Text="Volver" />
                    </td>
                </tr>
            </table>
            <br />
        </asp:Panel>

        <asp:Panel ID="pNuevoProducto" runat="server" ForeColor="#372C57" Height="430px" Visible="false">
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <h1>Nuevo Producto.</h1>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td align="left">
                        <h2>Nombre: </h2>
                    </td>
                    <td>
                        <asp:TextBox ID="tNombreProducto" runat="server" CssClass="form-control" Maxlenght="25" Width="360px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td></td>
                    <td align="center">
                        <asp:Label ID="lErrorNombre" runat="server" ForeColor="Red" Text="lErrorNombre" Visible="false"></asp:Label></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td align="left">
                        <h2>Precio: </h2>
                    </td>
                    <td>
                        <asp:TextBox ID="tPrecioProducto" runat="server" CssClass="form-control" Maxlenght="10" Width="360px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td></td>
                    <td align="center">
                        <asp:Label ID="lErrorPrecio" runat="server" ForeColor="Red" Text="lErrorPrecio" Visible="false"></asp:Label></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td align="left">
                        <h2>Stock: </h2>
                    </td>
                    <td>
                        <asp:TextBox ID="tStockProducto" runat="server" CssClass="form-control" Maxlenght="70" Width="360px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td></td>
                    <td align="center">
                        <asp:Label ID="lErrorStock" runat="server" ForeColor="Red" Text="lErrorStock" Visible="false"></asp:Label></td>
                    <td></td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lErrorAgregarProducto" runat="server" ForeColor="Red" Text="lErrorAgregarProducto" Visible="false"></asp:Label>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="bAgregarProd" runat="server" CssClass="btn btn-outline-primary" Font-Size="X-Large" Width="350px" Text="Agregar Producto" />
                    </td>
                    <td align="center">
                        <asp:Button ID="bCancelarProducto" runat="server" CssClass="btn btn-outline-danger" Font-Size="X-Large" Width="350px" Text="Cancelar" />
                    </td>
                    <td></td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pCambiarProducto" runat="server" ForeColor="#372C57" Visible="false">

            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <h1>Modificar Producto.</h1>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td align="left">
                        <h2>Producto: </h2>
                    </td>
                    <td>
                        <asp:DropDownList ID="dCambiarProductos" runat="server" CssClass="btn btn-primary dropdown-toggle" Width="360px">
                            <asp:ListItem>--Elija el Producto--</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td align="left">
                        <h2>Nombre: </h2>
                    </td>
                    <td>
                        <asp:TextBox ID="tCambiarNom" runat="server" CssClass="form-control" Maxlenght="25" Width="360px" ></asp:TextBox></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td></td>
                    <td align="center">
                        <asp:Label ID="lErrorCNombre" runat="server" ForeColor="Red" Text="lErrorCNombre" Visible="false"></asp:Label></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td align="left">
                        <h2>Precio: </h2>
                    </td>
                    <td>
                        <asp:TextBox ID="tCambiarPrecio" runat="server" CssClass="form-control" Maxlenght="10" Width="360px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td></td>
                    <td align="center">
                        <asp:Label ID="lErrorCPrecio" runat="server" ForeColor="Red" Text="lErrorCPrecio" Visible="false"></asp:Label></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td align="left">
                        <h2>Stock: </h2>
                    </td>
                    <td>
                        <asp:TextBox ID="tCambiarStock" runat="server" CssClass="form-control" Maxlenght="70" Width="360px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
                    <td></td>
                    <td align="center">
                        <asp:Label ID="lErrorCStock" runat="server" ForeColor="Red" Text="lErrorCStock" Visible="false"></asp:Label></td>
                    <td></td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lErrorCProducto" runat="server" ForeColor="Red" Text="lErrorCProducto" Visible="false"></asp:Label>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="bCambiarProd" runat="server" CssClass="btn btn-outline-success" Font-Size="X-Large" Width="300px" Text="Cambiar Producto" />
                    </td>
                    <td align="center">
                        <asp:Button ID="bVolverAreaAdmin" runat="server" CssClass="btn btn-outline-danger" Font-Size="X-Large" Width="300px" Text="Cancelar cambio" />
                    </td>
                    <td></td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pTodoslospedidos" runat="server" ForeColor="#372C57" Font-Size="Large" Visible="false">
            <table style="width: 100%">
                <tr>
                    <td style="height: 10px"></td>
                </tr>
                <tr>
                    <td align="center">
                        <h1>Historico de Pedidos y Revisar Estado</h1>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lErrorHistoricoAdmin" runat="server" Visible="False"
                            Text="lErrorHistoricoAdmin" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 10px"></td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:GridView ID="gTodosLosPedidos" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="750px">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:ButtonField ButtonType="Button" ControlStyle-CssClass="btn btn-primary" CommandName="Ver" Text="Ver Pedido" ></asp:ButtonField>
                                <asp:ButtonField ButtonType="Button" ControlStyle-CssClass="btn btn-warning" CommandName="Editar" Text="Editar" ></asp:ButtonField>
                                <asp:ButtonField ButtonType="Button" ControlStyle-CssClass="btn btn-danger" CommandName="Anular" Text="Anular Pedido" ></asp:ButtonField>
                                <asp:BoundField DataField="NPedido" HeaderText="N° Pedido" ReadOnly="True" />
                                <asp:BoundField DataField="NUM_CLI" HeaderText="N° Cliente" ReadOnly="True" />
                                <asp:BoundField DataField="fecha" DataFormatString="{0:dd/MM/yyyy HH:mm:tt}" HeaderText="Fecha y Hora" ReadOnly="True" />
                                <asp:BoundField DataField="estado" HeaderText="Estado del Pedido" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="Gray" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <br /><br />
            <table align="center">
                <tr>
                    <td>
                        <asp:Button ID="botonHistoricoAdminActualizar" runat="server" CssClass="btn btn-outline-success" Text="Actualizar" Font-Size="X-Large" Width="350px" />
                    </td>
                    <td>
                        <asp:Button ID="botonHistoricoAdminVolver" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Font-Size="X-Large" Width="350px" />
                    </td>
                </tr>
            </table>
            <br /><br />
        </asp:Panel>

        <asp:Panel ID="pVerPedidoAdmin" runat="server" ForeColor="#372C57" Visible="false" HorizontalAlign="Center">

            <br />
            <br />
            <br />
            <asp:Label ID="lNumeroPedidoAdmin" runat="server" Font-Size="XX-Large" Text="Pedido N° "></asp:Label>
            <br />
            &nbsp;<table style="width: 100%;">

                <tr>
                    <td align="center">
                        <asp:Label ID="lErrorVerPedidoAdmin" runat="server" ForeColor="#CC0000" Text="lErrorVerPedidoAdmin" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td align="center">&nbsp;
                        <asp:GridView ID="gVerPedidoAdmin" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" Width="600px">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>

                                <asp:BoundField DataField="Item" HeaderText="Item Solicitado" />
                                <asp:BoundField DataField="Cantidad" HeaderText="Cant." />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="botonVolverVerpedidoAdmin" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Font-Size="X-Large" Width="350px"  />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pEditarPedido" runat="server" ForeColor="#372C57" Visible="false">
            <br />
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lEditarPedido" runat="server" Font-Size="XX-Large" Text="Editar pedido N°"></asp:Label>
                        <asp:Label ID="lEditarNumeroPedido" runat="server" Font-Size="XX-Large" Text="-"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:GridView ID="gEditarPedido" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" CssClass="auto-style1" Width="600px">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:ButtonField ButtonType="Button" ControlStyle-CssClass="btn btn-danger" CommandName="Quitar" Text="Quitar" />
                                <asp:BoundField DataField="Item" HeaderText="Item Seleccionado" />
                                <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lErrorEditarPedido" runat="server" ForeColor="Red" Text="lErrorEditarPedido"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bEnviar" runat="server" CssClass="btn btn-outline-success" Text="Enviar" Font-Size="X-Large" Width="350px" />
                    </td>
                    <td align="center">
                        <asp:Button ID="bVolver" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Font-Size="X-Large" Width="350px" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pPedidoAnuladoAdmin" runat="server" ForeColor="#372C57" Visible="false">
            <br />
            <br />
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lPedidoAnuladoAdmin" runat="server" Text="El pedido fue ANULADO" Font-Size="X-Large" Visible="false"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td></td>
                    <td align="center">
                        <asp:Button ID="botonVolverPedidoAnuladoAdmin" runat="server" CssClass="btn btn-outline-danger" Text="Volver" Font-Size="X-Large" Width="350px" />
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
        </asp:Panel>

        <asp:Panel ID="pUsuarios" runat="server" ForeColor="#372C57" Visible="false" HorizontalAlign="Center">
            <br />
            <br />
            <br />
            <asp:Label ID="lResultadoUsuarios" runat="server" Font-Size="XX-Large" Text="Lista de usuarios:"></asp:Label>
            <br />
            <br />
            <table style="width: 100%;">
                <tr>
                    <td>
                        <asp:Label ID="lErrorGestionUsuario" runat="server" ForeColor="#CC0000" Text="lErrorGestionUsuario" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gListaDeUsuarios" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:ButtonField ButtonType="Button" ControlStyle-CssClass="btn btn-danger" CommandName="Eliminar" Text="Eliminar">
                                    <ControlStyle Font-Size="Large" Width="80px" />
                                    <HeaderStyle Font-Size="X-Large" Height="40px" />
                                    <ItemStyle Width="90px" Height="40px" />
                                </asp:ButtonField>
                                <asp:ButtonField ButtonType="Button" ControlStyle-CssClass="btn btn-warning" CommandName="Bloquear" Text="Bloquear">
                                    <ControlStyle Font-Size="Large" Width="90px" />
                                    <HeaderStyle Font-Size="X-Large" Height="40px" />
                                    <ItemStyle Width="75px" Height="40px" />
                                </asp:ButtonField>
                                <asp:ButtonField ButtonType="Button" ControlStyle-CssClass="btn btn-success" CommandName="Desbloquear" Text="Desbloquear">
                                    <ControlStyle Font-Size="Large" Width="120px" />
                                    <HeaderStyle Height="40px" />
                                    <ItemStyle Width="125px" Height="40px" />
                                </asp:ButtonField>
                                <asp:BoundField DataField="idUsuario" HeaderText="ID">
                                    <HeaderStyle Font-Size="Large" Height="40px" />
                                    <ItemStyle Width="55px" Height="40px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Nombre" HeaderText="Nombre">
                                    <HeaderStyle Font-Size="Large" Height="40px" />
                                    <ItemStyle Width="120px" Height="40px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Apellido" HeaderText="Apellido">
                                    <HeaderStyle Font-Size="Large" Height="40px" />
                                    <ItemStyle Width="120px" Height="40px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Estado" HeaderText="Estado">
                                    <HeaderStyle Font-Size="Large" Height="40px" />
                                    <ItemStyle Width="100px" Height="40px" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="Gray" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="bVolverResultadosUsuarios" runat="server" CssClass="btn btn-outline-danger" Font-Size="X-Large" Width="400px" Text="Volver" />
                    </td>
                </tr>
            </table>
            <br />
        </asp:Panel>

        <asp:Panel ID="pEliminarUsuario" runat="server" ForeColor="#372C57" Visible="false">
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lEliminarUsuario" runat="server" Font-Size="XX-Large" Text="Confirmar eliminación del usuario N°"></asp:Label>
                        <asp:Label ID="lEliminarUsuarioNumero" runat="server" Font-Size="XX-Large" Text="-"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="Label1" runat="server" Font-Size="X-Large" Text="Incluir mensaje:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tMensajeEliminar" runat="server" CssClass="form-control" Width="400px" Maxlenght="70"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lErrorEliminarUsuario" runat="server" ForeColor="red" Text="lErrorEliminarUsuario" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bEliminarUsuario" runat="server" CssClass="btn btn-danger" Font-Size="X-Large" Width="300px" Text="Eliminar" />
                    </td>
                    <td align="center">
                        <asp:Button ID="bCancelarEliminarUsuario" runat="server" CssClass="btn btn-outline-danger" Font-Size="X-Large" Width="300px" Text="Cancelar" />
                    </td>
                </tr>
            </table>
            <br />
        </asp:Panel>

        <asp:Panel ID="pConfirmacionDeCambio" runat="server" ForeColor="#372C57" Height="300px" Visible="false" HorizontalAlign="Center">
            <br />
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td alig="center">
                    <br />
                        <asp:Label ID="lConfirmacionDeCambio" runat="server" Font-Size="X-Large" Text="Usuario eliminado"></asp:Label>
                    <br />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                    <br />
                        <asp:Button ID="bVolverConfirmacionDeCambio" runat="server" CssClass="btn btn-outline-danger" Font-Size="X-Large" Width="300px" Text="Volver" />
                    <br />
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
        </asp:Panel>

        <asp:Panel ID="pBloquearUsuario" runat="server" ForeColor="#372C57" Visible="false">
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lBloquearUsuario" runat="server" Font-Size="XX-Large" Text="Confirmar bloqueo del usuario N°"></asp:Label>
                        <asp:Label ID="lBloquearUsuarioNumero" runat="server" Font-Size="XX-Large" Text="-"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Font-Size="X-Large" Text="Incluir mensaje:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tMensajeBloqueo" runat="server" CssClass="form-control" Font-Size="X-Large" ForeColor="White" MaxLength="400" Width="500px"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Label ID="lErrorBloquearUsuario" runat="server" ForeColor="Red" Text="lErrorBloquearUsuario" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bBloquearUsuario" runat="server" CssClass="btn btn-danger" Font-Size="X-Large" Width="300px" Text="Bloquear" />
                    </td>
                    <td align="center">
                        <asp:Button ID="bCancelarBloqueo" runat="server" CssClass="btn btn-outline-danger" Font-Size="X-Large" Width="300px" Text="Cancelar" />
                    </td>
                </tr>
            </table>
            <br />
            <br />
        </asp:Panel>

        <asp:Panel ID="pVerificaMail" runat="server" ForeColor="#372C57" Visible="false">
            <br />
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <h2>Te hemos enviado un código de verificación al email que ingresaste. Abrí
                            el mail, copiá el código, y pegalo en el cuadro de texto a continuación.
                            Luego oprimí Validar. Para corregir algún dato ingresado, oprimí
                            "Volver al Registro"; o bien "Cancelar y Volver" para anular la
                            operación y volver al Login.
                        </h2>
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:TextBox ID="tValidar" runat="server" CssClass="form-control" MaxLength="10" Width="100px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lCodigo" runat="server" ForeColor="Red" Text="***Codigo Incorrecto***" Visible="false"></asp:Label>
                    </td>
                </tr>
            </table>
            <br /><br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bValidar" runat="server" CssClass="btn btn-outline-success" Font-Size="X-Large" Width="300px" Text="Validar el Codigo" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bRegresarRegistro" runat="server" CssClass="btn btn-outline-warning" Font-Size="X-Large" Width="300px" Text="Volver al Registro" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="width:100%;">
                <tr>
                    <td align="center">
                        <asp:Button ID="bCancelarValidar" runat="server" CssClass="btn btn-outline-danger" Font-Size="X-Large" Width="300px" Text="Cancelar y volver" />
                    </td>
                </tr>
            </table>    
            <br />
            <br />
            <br />
        </asp:Panel>

    </form>
</body>
</html>
