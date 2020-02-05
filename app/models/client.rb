class Client < ApplicationRecord
	validates :cuit_cuil, presence: true, null: false, uniqueness: true
	validates :name, presence: true, null: false
	validates :email, presence: true, null: false, uniqueness: true
	enum iva_cond: {iva_responsable_inscripto: 1, iva_responsable_no_inscripto: 2, iva_no_responsable: 3, iva_sujeto_exento: 4, consumidor_final: 5, responsable_monotributo: 6, sujeto_no_categorizado: 7, proveedor_del_exterior: 8, cliente_del_exterior: 9, iva_liberado: 10, agente_de_percepcion: 11, pequeño_contribuyente_eventual: 12, monotributista_social: 13, pequeño_contribuyente_eventual_social: 14}
	validates :iva_cond, inclusion: { in: iva_conds.keys}
	validate :has_phones
	has_many :phones
	has_many :reservations
	has_many :sells
end

def has_phones
  	if self.phones.empty?
    	errors.add(:phones, "There are no phones")
  	end
end