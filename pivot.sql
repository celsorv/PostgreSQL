

-- PostgreSQL - PL/pgSQL
-- coloca os registros como colunas na mesma linha


CREATE TABLE "public"."tb_prescrito"
(
   id bigint PRIMARY KEY NOT NULL,
   id_medica bigint not null,
   data_registro timestamp NOT NULL
)
;

select id, id_medica as id_medicamento, data_registro from tb_prescrito order by data_registro;

select * from crosstab(
	$$select id_medica, dn, data_registro
		from (
			select id, id_medica, data_registro,
				row_number() over (partition by id_medica) as dn
			from tb_prescrito
			) sub
		where dn < 4
		order by id_medica
	$$,
	$$values (1),(2),(3)$$
	) as t (id_medicamento bigint, data_1 timestamp, data_2 timestamp, data_3 timestamp);

