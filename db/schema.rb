# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_26_141315) do

  create_table "aplicacaos", force: :cascade do |t|
    t.integer "tratamento_id"
    t.integer "pombo_id"
    t.datetime "dtaplicacao"
    t.float "dosagem"
    t.string "medida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pt_id"
    t.index ["pombo_id"], name: "index_aplicacaos_on_pombo_id"
    t.index ["tratamento_id"], name: "index_aplicacaos_on_tratamento_id"
  end

  create_table "clubes", force: :cascade do |t|
    t.string "nome"
    t.string "idregistro"
    t.string "email"
    t.string "logradouro"
    t.string "complemento"
    t.string "bairro"
    t.integer "cep"
    t.string "tel1"
    t.string "tel2"
    t.string "contato"
    t.integer "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cidade"
    t.integer "nacao_id"
    t.index ["estado_id"], name: "index_clubes_on_estado_id"
    t.index ["nacao_id"], name: "index_clubes_on_nacao_id"
  end

  create_table "competicaos", force: :cascade do |t|
    t.string "nome"
    t.integer "ano"
    t.integer "clb_id"
    t.integer "est_id"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_competicaos_on_usuario_id"
  end

  create_table "cors", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipes", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "usuario_id"
    t.index ["usuario_id"], name: "index_equipes_on_usuario_id"
  end

  create_table "equipes_pombos", id: false, force: :cascade do |t|
    t.integer "equipe_id"
    t.integer "pombo_id"
    t.index ["equipe_id"], name: "index_equipes_pombos_on_equipe_id"
    t.index ["pombo_id"], name: "index_equipes_pombos_on_pombo_id"
  end

  create_table "estados", force: :cascade do |t|
    t.string "nome"
    t.string "sigla"
    t.integer "nacao_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nacao_id"], name: "index_estados_on_nacao_id"
  end

  create_table "nacaos", force: :cascade do |t|
    t.string "nome"
    t.string "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale"
  end

  create_table "planos", force: :cascade do |t|
    t.string "tipo"
    t.datetime "dtinicio_pagto"
    t.datetime "dtcancelamento"
    t.float "valor_mensal"
    t.string "moeda"
    t.string "id_recorrencia_operadora"
    t.string "url_recorrencia_operadora"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_planos_on_usuario_id"
  end

  create_table "pombal_tratamentos", force: :cascade do |t|
    t.integer "pombal_id"
    t.integer "tratamento_id"
    t.datetime "dtinicio"
    t.datetime "dtfim"
    t.boolean "lembrar"
    t.integer "qtde"
    t.string "intervalo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pombal_id"], name: "index_pombal_tratamentos_on_pombal_id"
    t.index ["tratamento_id"], name: "index_pombal_tratamentos_on_tratamento_id"
  end

  create_table "pombals", force: :cascade do |t|
    t.string "nome"
    t.datetime "dtdesativ"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_pombals_on_usuario_id"
  end

  create_table "pombals_pombos", id: false, force: :cascade do |t|
    t.integer "pombal_id"
    t.integer "pombo_id"
    t.index ["pombal_id"], name: "index_pombals_pombos_on_pombal_id"
    t.index ["pombo_id"], name: "index_pombals_pombos_on_pombo_id"
  end

  create_table "pombos", force: :cascade do |t|
    t.string "anilha"
    t.string "nome"
    t.datetime "dtnasc"
    t.string "sexo"
    t.integer "cor_id"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "vivo", default: true
    t.integer "pai_id"
    t.integer "mae_id"
    t.index ["cor_id"], name: "index_pombos_on_cor_id"
    t.index ["id", "mae_id"], name: "index_pombos_on_id_and_mae_id", unique: true
    t.index ["id", "pai_id"], name: "index_pombos_on_id_and_pai_id", unique: true
    t.index ["usuario_id"], name: "index_pombos_on_usuario_id"
  end

  create_table "preparos", force: :cascade do |t|
    t.string "nome"
    t.string "descricao"
    t.integer "tipo_prova"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_preparos_on_usuario_id"
  end

  create_table "prova_preparos", force: :cascade do |t|
    t.integer "prova_id"
    t.integer "preparo_id"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["preparo_id"], name: "index_prova_preparos_on_preparo_id"
    t.index ["prova_id"], name: "index_prova_preparos_on_prova_id"
    t.index ["usuario_id"], name: "index_prova_preparos_on_usuario_id"
  end

  create_table "provas", force: :cascade do |t|
    t.string "nome"
    t.datetime "dtsolta"
    t.integer "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "competicao_id"
    t.integer "usuario_id"
    t.string "lat"
    t.string "lng"
    t.string "lat_card"
    t.float "lat_deg"
    t.float "lat_min"
    t.float "lat_seg"
    t.string "lng_card"
    t.float "lng_deg"
    t.float "lng_min"
    t.float "lng_seg"
    t.index ["competicao_id"], name: "index_provas_on_competicao_id"
    t.index ["usuario_id"], name: "index_provas_on_usuario_id"
  end

  create_table "resultado_importados", force: :cascade do |t|
    t.integer "classif"
    t.string "ring"
    t.integer "year"
    t.string "p_sn"
    t.string "d_sn"
    t.string "e_sn"
    t.integer "idcriador"
    t.string "nomecriador"
    t.string "date"
    t.string "time"
    t.float "distance"
    t.float "veloc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "points"
  end

  create_table "resultados", force: :cascade do |t|
    t.integer "prova_id"
    t.integer "pombo_id"
    t.datetime "dhrestimada"
    t.datetime "dhroficial"
    t.integer "posicao"
    t.float "pontos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "usuario_id"
    t.float "dist_oficial"
    t.float "veloc_oficial"
    t.index ["pombo_id"], name: "index_resultados_on_pombo_id"
    t.index ["prova_id"], name: "index_resultados_on_prova_id"
    t.index ["usuario_id"], name: "index_resultados_on_usuario_id"
  end

  create_table "titulos", force: :cascade do |t|
    t.string "nome"
    t.integer "ano"
    t.integer "pombo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pombo_id"], name: "index_titulos_on_pombo_id"
  end

  create_table "tratamentos", force: :cascade do |t|
    t.string "nome"
    t.string "indicacao"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_tratamentos_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.integer "tipo_usuario"
    t.string "tel1"
    t.string "tel2"
    t.string "lat"
    t.string "lng"
    t.string "lingua"
    t.string "fuso"
    t.integer "estado_id"
    t.string "numero_cartao"
    t.string "nome_cartao"
    t.string "dtexpirado"
    t.string "bandeira_cartao"
    t.integer "nacao_id"
    t.integer "passo_criacao"
    t.string "lat_card"
    t.float "lat_deg"
    t.float "lat_min"
    t.float "lat_seg"
    t.string "lng_card"
    t.float "lng_deg"
    t.float "lng_min"
    t.float "lng_seg"
    t.string "logradouro"
    t.string "nome_time"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["nacao_id"], name: "index_usuarios_on_nacao_id"
  end

end
