/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * Utilidades.vala
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
public class Utilidades : GLib.Object {
	public static int devolver_num_rows (string tabla) {
		Sqlite.Database db;
		//string errmsg;

		// Open a database:
		int ec = Sqlite.Database.open (database_name, out db);
		if (ec != Sqlite.OK) {
			stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
			return -1;
		}

		//
		// Create a prepared statement:
		// (db.prepare shouldn't be used anymore)
		//
		Sqlite.Statement stmt;
		//const
		string prepared_query_str = "SELECT count(*) FROM " + tabla + ";";
		ec = db.prepare_v2 (prepared_query_str, prepared_query_str.length, out stmt);
		if (ec != Sqlite.OK) {
			stderr.printf ("Error: %d: %s\n", db.errcode (), db.errmsg ());
			return -1;
		}

		//
		// Use the prepared statement:
		//
		stmt.step ();
		int n_rows = stmt.column_int (0);
		//print ("Nº: %d\n", n_rows);
		stmt.reset ();
		return n_rows;
		//return stmt.column_int (0);
	}
}
