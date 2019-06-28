/*
 * fichacliente.vala
 * Copyright (C) 2019 Bartolome Vich Lozano <tolo@tovilo.es>
 * 
 * fichaClientes is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * fichaClientes is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using GLib;
using Gtk;

const string database_name = "ant.db";

public class Main : Object 
{

	const string UI_FILE = "fichaclientes.ui";

	/* ANJUTA: Widgets declaration for fichaclientes.ui - DO NOT REMOVE */
	Gtk.SpinButton spinbox;
	Gtk.Entry id_entry;
	Gtk.Entry nif_entry;
	Gtk.Entry nombre_entry;
	Gtk.Entry apellidos_entry;
	Gtk.Entry tel1_entry;
	Gtk.Entry tel2_entry;
	Gtk.Entry email_entry;
	Gtk.Entry domicilio_entry;
	Gtk.Entry cp_entry;
	Gtk.Entry ciudad_entry;
	Gtk.Entry varios_entry;
	Gtk.Button guardar_button; 
	Gtk.Button primero_button;
	Gtk.Button ultimo_button;
	Gtk.Button nuevo_button;
	Gtk.Button salir_button;
	

	//The buttons have a "normal" state
	private bool estado_button_guardar = true;
	private bool estado_button_nuevo = true;
	 
	public Main ()
	{

		try 
		{
			var builder = new Builder ();
			builder.add_from_file (UI_FILE);
			builder.connect_signals (this);

			var window = builder.get_object ("window") as Window;

			/* ANJUTA: Widgets initialization for fichaclientes.ui - DO NOT REMOVE */
		
			spinbox = builder.get_object("spinbox") as Gtk.SpinButton;
			primero_button = builder.get_object ("primero_button") as Gtk.Button;
			ultimo_button = builder.get_object ("ultimo_button") as Gtk.Button;
			nuevo_button = builder.get_object ("nuevo_button") as Gtk.Button;
			guardar_button = builder.get_object ("guardar_button") as Gtk.Button;
			salir_button = builder.get_object ("salir_button") as Gtk.Button;

		
			/* Gtk Entries*/
			id_entry = builder.get_object ("id_entry") as Gtk.Entry;
			nif_entry = builder.get_object ("nif_entry") as Gtk.Entry;
			nombre_entry = builder.get_object ("nombre_entry") as Gtk.Entry;
			apellidos_entry = builder.get_object ("apellidos_entry") as Gtk.Entry;
			tel1_entry = builder.get_object ("tel1_entry") as Gtk.Entry;
			tel2_entry = builder.get_object ("tel2_entry") as Gtk.Entry;
			email_entry = builder.get_object ("email_entry") as Gtk.Entry;
			domicilio_entry = builder.get_object ("domicilio_entry") as Gtk.Entry;
			cp_entry = builder.get_object ("cp_entry") as Gtk.Entry;
			ciudad_entry = builder.get_object ("ciudad_entry") as Gtk.Entry;
			varios_entry = builder.get_object ("varios_entry") as Gtk.Entry;
			                               
			window.show_all ();
			window.set_title ("Ficha Clientes");
			id_entry.set_sensitive (false);
			spinbox.set_digits (0); //Delete decimals

			refrescar_rangos(); //Put range values on the spinbutton (spinbox)
	
			mostrar();
		
			spinbox.value_changed.connect(() => {
				mostrar ();
			});

			primero_button.clicked.connect(() => {
				spinbox.set_value (1);
			});

			ultimo_button.clicked.connect(() => {
				spinbox.set_value (Utilidades.devolver_num_rows("clientes"));
			});

			nuevo_button.clicked.connect(() => {
				
				if (estado_button_nuevo == true) {

					vaciar_entries ();

					modo_insertar ();
					//Rellenamos los campos y habilitamos el botón insertar


				} else {
					
					/* The insert, it will be canceled*/
					mostrar(); 

					modo_guardar ();

					
				}
			});	
				
			guardar_button.clicked.connect(() => {
				if (estado_button_guardar == true ) {

					ControladorCliente.insertar (crear_desde_ficha (),
					                             true,
					                             id_entry.get_text ()
					                             );
				} else {


					ControladorCliente.insertar (crear_desde_ficha ());

					refrescar_rangos();
					
					spinbox.set_value (Utilidades.devolver_num_rows("clientes"));

					mostrar ();

					modo_guardar ();
					                                                 
				}
			});
		
			
			salir_button.clicked.connect(() => {
				Gtk.main_quit();
			});

	} catch (Error e) {
			stderr.printf ("Could not load UI: %s\n", e.message);
		} 

	}

	private void refrescar_rangos()
	{
		spinbox.set_range (1,Utilidades.devolver_num_rows ("clientes"));
		spinbox.set_increments (1,Utilidades.devolver_num_rows ("clientes"));
		ultimo_button.label = Utilidades.devolver_num_rows("clientes").to_string ();
	}
	 
	private void mostrar()
	{
		Cliente cliente = new Cliente();
		
		ControladorCliente.obtener ((int)spinbox.get_value (), cliente);


			
			id_entry.text = cliente.get_id ().to_string ();
			nif_entry.text = cliente.get_nif ();
			nombre_entry.text = cliente.get_nombre ();
			apellidos_entry.text = cliente.get_apellidos ();
			email_entry.text = cliente.get_email ();
			tel1_entry.text = cliente.get_tel1 ();
			tel2_entry.text = cliente.get_tel2 ();
			domicilio_entry.text = cliente.get_domicilio ();
			cp_entry.text = cliente.get_cp ();
			ciudad_entry.text = cliente.get_ciudad ();
			varios_entry.text = cliente.get_varios ();

			
	}

	private void vaciar_entries() 
	 {
		id_entry.text = "_";
		nif_entry.text = "";
		nombre_entry.text = "";
		apellidos_entry.text = "";
		email_entry.text = "";
		tel1_entry.text = "";
		tel2_entry.text = "";
		domicilio_entry.text = "";
		cp_entry.text = "";
		ciudad_entry.text = "";
		varios_entry.text = "";		
		
	}

	private void modo_guardar() 
	{
		ultimo_button.set_sensitive (true);
		primero_button.set_sensitive (true);
		spinbox.set_sensitive (true);
		guardar_button.label = "Guardar";
		nuevo_button.label = "Nuevo";

		//The button_nuevo & button_guardar have a "normal state"
		estado_button_nuevo = true;
		estado_button_guardar = true;		
	}

	private void modo_insertar()
	{
		ultimo_button.set_sensitive (false);
		primero_button.set_sensitive (false);
		spinbox.set_sensitive (false);
		guardar_button.label = "Insertar";
		nuevo_button.label = "Cancelar";

		//button_nuevo & button_guardar do not have a "normal state"
		estado_button_nuevo = false;
		estado_button_guardar = false;
	}

	private Cliente crear_desde_ficha() 
	{
		Cliente cliente = new Cliente.constructor_with_all (nif_entry.get_text (),
			                                                nombre_entry.get_text (),
			                                                apellidos_entry.get_text (),
			                                                tel1_entry.get_text (),
			                                                tel2_entry.get_text (),
			                                                email_entry.get_text (),
			                                                domicilio_entry.get_text (),
			                                                cp_entry.get_text (),
			                                                ciudad_entry.get_text (),
			                                                varios_entry.get_text ());
		return cliente;

	}
	 
	[CCode (instance_pos = -1)]
	public void on_destroy (Widget window) 
	{
		Gtk.main_quit();
	}

	static int main (string[] args) 
	{
		Gtk.init (ref args);
		var app = new Main ();

		Gtk.main ();
		
		return 0;
	}
}

