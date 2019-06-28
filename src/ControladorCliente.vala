/*
 * ControladorCliente.vala
 * Copyright (C) 2019 Bartolome Vich Lozano <tolo@tovilo.es> 28-6-2019
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
using Sqlite;

public class ControladorCliente : GLib.Object {


	private static Sqlite.Database db;
	private static string errmsg;

	private static int abrir_bd () {
		int ec = Sqlite.Database.open (database_name, out db);
		return ec;
	}
	private static void imprimir_error_abrir_bd () {
		stderr.printf ("No se pudo abrir la bd: %d: %s\n", db.errcode (), db.errmsg ());
	}
	
	public static Cliente obtener(int id, Cliente cliente)
	{


		
		// Open a database:
		if (abrir_bd () != Sqlite.OK) {
			imprimir_error_abrir_bd ();

			cliente.set_id(0);
			return cliente;
		}

		//
		// Create a prepared statement:
		// (db.prepare shouldn't be used anymore)
		//
		Sqlite.Statement stmt;

		string prepared_query_str = "SELECT Id, nif, nombre, apellidos, tel, tel2, 
									email, domicilio, cp, ciudad, otros 
									FROM  clientes WHERE Id=" + id.to_string () + ";";
		
		int ec = db.prepare_v2 (prepared_query_str, prepared_query_str.length, out stmt);

		if (ec != Sqlite.OK) {
			stderr.printf ("Error: %d: %s\n", db.errcode (), db.errmsg ());
			cliente.set_id(0);
			return cliente;
		}

		stmt.step ();
		
		//Object assign fields	
		cliente.set_id(stmt.column_int (0));
		cliente.set_nif(stmt.column_text(1));
		cliente.set_nombre(stmt.column_text(2));
		cliente.set_apellidos(stmt.column_text(3));
		cliente.set_tel1(stmt.column_text(4));
		cliente.set_tel2(stmt.column_text(5));
		cliente.set_email(stmt.column_text(6));
		cliente.set_domicilio(stmt.column_text(7));
		cliente.set_cp(stmt.column_text(8));
		cliente.set_ciudad(stmt.column_text(9));
		cliente.set_varios(stmt.column_text(10));

		stmt.reset ();

		return cliente;
	}
	
	//Insert a new cliente in the database
	public static bool insertar(Cliente cliente, 
	                            bool modificacion = false,
	                            string id = "0" ) 
	{
		if (abrir_bd () != Sqlite.OK) {
			imprimir_error_abrir_bd ();	
			return false;
		}


		string query;
		if (modificacion == false ) {
			
			query = "
			INSERT INTO clientes (nif, nombre, apellidos, tel, tel2, email, domicilio, cp, ciudad, otros) 
			VALUES ('"
				    + cliente.get_nif () + "','"
					+ cliente.get_nombre () + "','" 
					+ cliente.get_apellidos () + "','"
					+ cliente.get_tel1 () + "','"
					+ cliente.get_tel2 () + "','" 
					+ cliente.get_email () + "','" 
					+ cliente.get_domicilio () + "','"
					+ cliente.get_cp () + "','" 
					+ cliente.get_ciudad () + "','"
					+ cliente.get_varios () + "'"
					+ ");";

		} else {
			
			query = "UPDATE clientes SET nif ='" + cliente.get_nif () + "',"
							  + "nombre ='" + cliente.get_nombre () + "',"
							  + "apellidos ='" + cliente.get_apellidos () + "',"
							  + "tel ='" + cliente.get_tel1 () + "',"
							  + "tel2 ='" + cliente.get_tel2 () + "',"
							  + "email ='" + cliente.get_email () + "',"
							  + "domicilio='" + cliente.get_domicilio () + "',"
				                          + "cp ='" + cliente.get_cp () + "',"
							  + "ciudad ='" + cliente.get_ciudad () + "',"
				                          + "otros ='" + cliente.get_varios () 
							  + "' WHERE Id =" + id + ";" ;
			
		}
		
		int ec = db.exec (query, null, out errmsg);

		if (ec != Sqlite.OK) {
			stderr.printf ("Error: %s\n", errmsg);
			return false;
		}
		
		return true;
	}
	public static bool modificar( int id) {
		
		return true;
	}
}
