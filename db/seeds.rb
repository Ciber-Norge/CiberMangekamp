# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.find_or_create_by(title: 'Kondisjon', color: '#e74c3c')
Category.find_or_create_by(title: 'Teknikk', color: '#3498db')
Category.find_or_create_by(title: 'Balløvelser', color: '#2ecc71')
