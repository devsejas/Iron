# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Item.destroy_all
Company.destroy_all
Country.destroy_all
Warehouse.destroy_all
Category.destroy_all
Modulo.destroy_all


Country.create([
	{   
		name: "Bolivia",
		code: "BO",
		phone_code: "+591"

	},
	{   
		name: "Brasil",
		code: "BR",
		phone_code: "+55"

	},
	{   
		name: "Alemania",
		code: "AL",
		phone_code: "+49"

	},
	{   
		name: "Japon",
		code: "JP",
		phone_code: "+81"

	},
	{     
		name: "China",
		code: "CH",
		phone_code: "+86"

	}
])

p "Created Conutres #{Country.count} entries."



Warehouse.create([
	{
		id:1,
		ref:"#A001",
		name: "Mi Almacen",
		description: "Este alamacen no se usa para realizar operaciones",
		active:true,
		
	}
])

p "Created Warehouse #{Warehouse.count} entries."


Category.create([
	{		
		name:"Herramientas",				
	},
	{		
		name:"Brocas",				
	},
	{		
		name:"Pernos",				
	},
	{		
		name:"Soldaduras",				
	}
])

p "Created Category #{Category.count} entries."




Company.create([
	{
		
		name: "Mi Compañia",
		nit: "6465114",
		email: "micompañia@gmail.com",
		phone: "4455442",
		company_registration: "00000",
		report_footer: "compañia",
		mycompany: true,
		country_id: Country.first.id
		
		
		
	}
])

p "Created Company #{Company.count} entries."

Modulo.create([
	{
		name: "Inicio",
		active: false,
		color: "btn btn-icons-navbar fcbtn  fcbtn  btn-primary btn-outline btn-1c",
		icon: "fas fa-tv",
		installed: true			
		
	},
	
	{
		name: "Productos",
		active: false,
		color: "btn btn-icons-navbar fcbtn  fcbtn  btn-primary btn-outline btn-1c",
		icon: "fas fa-box",
		installed: true			
		
	},
	{
		name: "Comercial",
		active: false,
		color: "btn btn-icons-navbar fcbtn  fcbtn  btn-primary btn-outline btn-1c",
		icon: "fas fa-handshake",
		installed: true			
		
	},
	{
		name: "Contabilidad",
		active: false,
		color: "btn btn-icons-navbar fcbtn  fcbtn  btn-primary btn-outline btn-1c",
		icon: "fas fa-calculator",
		installed: true			
		
	},
	{
		name: "Ajustes",
		active: false,
		color: "btn btn-icons-navbar fcbtn  fcbtn  btn-primary btn-outline btn-1c",
		icon: "fas fa-cogs",
		installed: true			
		
	},
	
])

p "Created Modulo #{Modulo.count} entries."

Rol.create([
	{
		name: "Administrador",
		permision: 6			
		
	},
	
	{
		name: "Gerente",
		permision: 5
	},
	{
		name: "Vendedor",
		permision: 2
		
	},
	{
		name: "Invitador",
		permision: 1
		
	},
	{
		name: "Alacenero",
		permision: 3	
		
	},
	
])

p "Created Rol #{Rol.count} entries."

