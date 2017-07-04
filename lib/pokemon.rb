class Pokemon

	attr_accessor :name, :type, :db, :id, :hp

	def initialize (id:, name:, type:, db:)
		@name = name
		@type = type
		@db = db
		@id = id
	end

	def self.save(name, type, db)
		ins = db.prepare('INSERT INTO pokemon (name, type) values (?, ?)')
		ins.execute(name, type)
	end

	def self.find(id, db)
		args = {}
		pokemon_data = db.execute("SELECT * FROM pokemon WHERE pokemon.id = #{id}")
		args[:id] = pokemon_data.flatten[0]
		args[:name] = pokemon_data.flatten[1]
		args[:type] = pokemon_data.flatten[2]
		args[:db] = db

		found_pokemon = self.new(args)
		found_pokemon.hp = pokemon_data.flatten[3]
		found_pokemon
	end

	def alter_hp(new_hp, db)
		alt = db.prepare('UPDATE pokemon SET hp = (?) WHERE id = (?)')
		alt.execute(new_hp, self.id)
	end

end
