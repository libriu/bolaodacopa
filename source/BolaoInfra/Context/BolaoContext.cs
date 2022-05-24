using System;
using System.Collections.Generic;
using BolaoInfra.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.Extensions.Configuration;

namespace BolaoInfra.Context
{
    public partial class BolaoContext : DbContext
    {
        public IConfiguration ConfigurationMngr { get; }

        public BolaoContext()
        {
        }

        public BolaoContext(DbContextOptions<BolaoContext> options, IConfiguration configuration)
            : base(options)
        {
            ConfigurationMngr = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var cnn = System.Configuration.ConfigurationManager.ConnectionStrings["BolaoConnectionString"].ConnectionString;
            optionsBuilder.UseSqlServer(cnn);
        }

        public virtual DbSet<Apostador> Apostadores { get; set; }
        public virtual DbSet<Aposta> Apostas { get; set; }
        public virtual DbSet<Grupo> Grupos { get; set; }
        public virtual DbSet<Jogo> Jogos { get; set; }
        public virtual DbSet<Mensagem> Mensagens { get; set; }
        public virtual DbSet<Pais> Paises { get; set; }
        public virtual DbSet<Ranking> Rankings { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Apostador>(entity =>
            {
                entity.HasKey(e => e.CodApostador);

                entity.ToTable("Apostador");

                entity.HasIndex(e => e.Login, "IX_Apostador")
                    .IsUnique();

                entity.Property(e => e.CodApostador).HasColumnName("cod_apostador");

                entity.Property(e => e.AcessoAtivacao).HasColumnName("acesso_ativacao");

                entity.Property(e => e.AcessoGestaoTotal).HasColumnName("acesso_gestao_total");

                entity.Property(e => e.Ativo).HasColumnName("ativo");

                entity.Property(e => e.Celular)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("celular");

                entity.Property(e => e.Cidade)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("cidade");

                entity.Property(e => e.CodApostAtivador).HasColumnName("cod_apost_ativador");

                entity.Property(e => e.Contato)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("contato");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("email");

                entity.Property(e => e.Login)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("login");

                entity.Property(e => e.Senha)
                    .IsRequired()
                    .HasMaxLength(512)
                    .IsUnicode(false)
                    .HasColumnName("senha");

                entity.HasOne(d => d.ApostadorAtivador)
                    .WithMany(p => p.ApostadoresAtivados)
                    .HasForeignKey(d => d.CodApostAtivador)
                    .HasConstraintName("FK_Apostador_Apostador");
            });

            modelBuilder.Entity<Aposta>(entity =>
            {
                entity.HasKey(e => new { e.CodApostador, e.CodJogo });

                entity.Property(e => e.CodApostador).HasColumnName("cod_apostador");

                entity.Property(e => e.CodJogo).HasColumnName("cod_jogo");

                entity.Property(e => e.PlacarA).HasColumnName("placar_A");

                entity.Property(e => e.PlacarB).HasColumnName("placar_B");

                entity.Property(e => e.Pontos).HasColumnName("pontos");

                entity.HasOne(d => d.Apostador)
                    .WithMany(p => p.Apostas)
                    .HasForeignKey(d => d.CodApostador)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Aposta_Apostador");

                entity.HasOne(d => d.Jogo)
                    .WithMany(p => p.Apostas)
                    .HasForeignKey(d => d.CodJogo)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Aposta_Jogo");
            });

            modelBuilder.Entity<Grupo>(entity =>
            {
                entity.HasKey(e => e.CodGrupo)
                    .HasName("PK__Grupos__A96FAFAE33856D52");

                entity.ToTable("Grupo");

                entity.Property(e => e.CodGrupo).HasColumnName("cod_grupo");

                entity.Property(e => e.CodApostResponsavel).HasColumnName("cod_apost_responsavel");

                entity.Property(e => e.Nome)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("nome");

                entity.HasOne(d => d.ApostadorResponsavel)
                    .WithMany(p => p.GruposResponsavel)
                    .HasForeignKey(d => d.CodApostResponsavel)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Grupo_Apostador");

                entity.HasMany(d => d.Apostadores)
                    .WithMany(p => p.Grupos)
                    .UsingEntity<Dictionary<string, object>>(
                        "GrupoApostador",
                        l => l.HasOne<Apostador>().WithMany().HasForeignKey("CodApostador").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_GrupoApostador_Apostador"),
                        r => r.HasOne<Grupo>().WithMany().HasForeignKey("CodGrupo").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_GrupoApostador_Grupo"),
                        j =>
                        {
                            j.HasKey("CodGrupo", "CodApostador");

                            j.ToTable("GrupoApostador");

                            j.IndexerProperty<int>("CodGrupo").HasColumnName("cod_grupo");

                            j.IndexerProperty<int>("CodApostador").HasColumnName("cod_apostador");
                        });
            });

            modelBuilder.Entity<Jogo>(entity =>
            {
                entity.HasKey(e => e.CodJogo);

                entity.ToTable("Jogo");

                entity.Property(e => e.CodJogo).HasColumnName("cod_jogo");

                entity.Property(e => e.CodPaisA).HasColumnName("cod_paisA");

                entity.Property(e => e.CodPaisB).HasColumnName("cod_paisB");

                entity.Property(e => e.DataHora)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("data_hora");

                entity.Property(e => e.Grupo)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasColumnName("grupo");

                entity.Property(e => e.JaOcorreu).HasColumnName("ja_ocorreu");

                entity.Property(e => e.RPlacarA).HasColumnName("r_placar_A");

                entity.Property(e => e.RPlacarB).HasColumnName("r_placar_B");

                entity.HasOne(d => d.PaisA)
                    .WithMany(p => p.JogosA)
                    .HasForeignKey(d => d.CodPaisA)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Jogo_PaisA");

                entity.HasOne(d => d.PaisB)
                    .WithMany(p => p.JogosB)
                    .HasForeignKey(d => d.CodPaisB)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Jogo_PaisB");
            });

            modelBuilder.Entity<Mensagem>(entity =>
            {
                entity.HasKey(e => e.CodMensagem);

                entity.ToTable("Mensagem");

                entity.Property(e => e.CodMensagem).HasColumnName("cod_mensagem");

                entity.Property(e => e.CodApostador).HasColumnName("cod_apostador");

                entity.Property(e => e.DataHora)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("data_hora");

                entity.Property(e => e.Texto)
                    .IsRequired()
                    .HasMaxLength(2000)
                    .IsUnicode(false)
                    .HasColumnName("texto");

                entity.HasOne(d => d.Apostador)
                    .WithMany(p => p.Mensagens)
                    .HasForeignKey(d => d.CodApostador)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Mensagem_Apostador");
            });

            modelBuilder.Entity<Pais>(entity =>
            {
                entity.HasKey(e => e.CodPais);

                entity.HasIndex(e => e.Nome, "IX_Pais")
                    .IsUnique();

                entity.Property(e => e.CodPais).HasColumnName("cod_pais");

                entity.Property(e => e.Arquivo)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("arquivo");

                entity.Property(e => e.Nome)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("nome");
            });

            modelBuilder.Entity<Ranking>(entity =>
            {
                entity.HasKey(e => e.CodApostador);

                entity.ToTable("Ranking");

                entity.Property(e => e.CodApostador)
                    .ValueGeneratedNever()
                    .HasColumnName("cod_apostador");

                entity.Property(e => e.TotalAcertos).HasColumnName("total_acertos");

                entity.Property(e => e.TotalPontos).HasColumnName("total_pontos");

                entity.HasOne(d => d.Apostador)
                    .WithOne(p => p.Ranking)
                    .HasForeignKey<Ranking>(d => d.CodApostador)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Ranking_Apostador");

            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
