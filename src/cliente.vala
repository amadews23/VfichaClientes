/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * cliente.vala 
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

public class Cliente : GLib.Object {

	 /*Fields*/
	 private int id;
	 private string nif;
	 private string nombre;
	 private string apellidos;
	 private string tel1;
	 private string tel2;
	 private string email;
	 private string domicilio;
	 private string cp;
	 private string ciudad;
	 private string varios;

	 /*Constructor*/
	 public Cliente() {

	 }
	
	 public Cliente.constructor_with_all(string nif, 
	                                     string nombre, 
	                                     string apellidos, 
	                                     string tel1,
	                                     string tel2,
	                                     string email,
	                                     string domicilio,
	                                     string cp,
	                                     string ciudad,
	                                     string varios) {

		 //this.id = id; //el id lo asigna la base de datos
		 this.nif = nif;	 
		 this.nombre = nombre;	
		 this.apellidos = apellidos;	
		 this.tel1 = tel1;
		 this.tel2 = tel2;
		 this.email= email;	
		 this.domicilio = domicilio;
		 this.cp = cp;	
		 this.ciudad = ciudad;
		 this.varios = varios;
	 }

	
	 /*Methods*/
	
	 /*getters*/
	 public int get_id() {
		return this.id;
	 }
	 public string get_nif() {
		return this.nif;
	 } 
	 public string get_nombre() {
		return this.nombre;
	 }
	 public string get_apellidos() {
		return this.apellidos;
	 }	
	 public string get_tel1() {
		return this.tel1;
	 }
	 public string get_tel2() {
		return this.tel2;
	 }
	 public string get_email() {
		return this.email;
	 }
	 public string get_domicilio() {
		return this.domicilio;
	 }
	 public string get_cp() {
		return this.cp;
	 }
	 public string get_ciudad() {
		return this.ciudad;
	 }
	 public string get_varios() {
		return this.varios;
	 }	
	
	 /*setters*/
	public void set_id( int id ) {
		this.id = id;
	}
	public void set_nif( string nif) {
		this.nif = nif;
	}
	public void set_nombre (string nombre) {
		this.nombre = nombre;
	}
	public void set_apellidos (string apellidos) {
		this.apellidos = apellidos;
	}
	public void set_tel1 (string tel1) {
		this.tel1 = tel1;
	}
	public void set_tel2 (string tel2) {
		this.tel2 = tel2;
	}
	public void set_email (string email) {
		this.email = email;
	}
	public void set_domicilio (string domicilio) {
		this.domicilio = domicilio;
	}
	public void set_cp (string cp) {
		this.cp = cp;
	}
	public void set_ciudad (string ciudad) {
		this.ciudad = ciudad;
	}
	public void set_varios (string varios) {
		this.varios = varios;
	}
	
}
