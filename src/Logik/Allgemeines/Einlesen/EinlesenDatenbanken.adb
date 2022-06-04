pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartengrundDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;
with KartenflussDatenbank;
with KartenressourcenDatenbank;

package body EinlesenDatenbanken is
   
   procedure EinlesenAlleDatenbanken
   is begin
      
      EinlesenEinheitenDatenbank;
      EinlesenForschungenDatenbank;
      EinlesenGebäudeDatenbank;
      EinlesenKartengrundDatenbank;
      EinlesenVerbesserungenDatenbank;
      EinlesenRassenDatenbank;
      
   end EinlesenAlleDatenbanken;
   
   

   procedure EinlesenEinheitenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/EinheitenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/EinheitenDatenbank");

         when False =>
            EinheitenDatenbank.StandardEinheitenDatenbankLaden;
            return;
      end case;
      
      EinheitenDatenbank.EinheitenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                   EinheitenDatenbank.Einheitenliste);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenEinheitenDatenbank;
   
   
   
   procedure EinlesenForschungenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/ForschungenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/ForschungenDatenbank");

         when False =>
            ForschungenDatenbank.StandardForschungenDatenbankLaden;
            return;
      end case;
      
      ForschungenDatenbank.ForschungslisteArray'Read (Stream (File => DatenbankEinlesen),
                                                    ForschungenDatenbank.Forschungsliste);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenForschungenDatenbank;
   
   
   
   procedure EinlesenGebäudeDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/GebaeudeDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/GebaeudeDatenbank");

         when False =>
            GebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
            return;
      end case;
      
      GebaeudeDatenbank.GebäudelisteArray'Read (Stream (File => DatenbankEinlesen),
                                                 GebaeudeDatenbank.Gebäudeliste);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenGebäudeDatenbank;
   
   
   
   procedure EinlesenKartengrundDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/KartenGrundDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/KartenGrundDatenbank");

         when False =>
            KartengrundDatenbank.StandardKartengrundDatenbankLaden;
            return;
      end case;
      
      KartengrundDatenbank.KartengrundlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                  KartengrundDatenbank.Kartengrundliste);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => "Datenbanken/KartenFlussDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/KartenFlussDatenbank");

         when False =>
            KartenflussDatenbank.StandardKartenflussDatenbankLaden;
            return;
      end case;
      
      KartenflussDatenbank.KartenflusslisteArray'Read (Stream (File => DatenbankEinlesen),
                                                  KartenflussDatenbank.Kartenflussliste);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => "Datenbanken/KartenRessourcenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/KartenRessourcenDatenbank");

         when False =>
            KartenressourcenDatenbank.StandardKartenressourcenDatenbankLaden;
            return;
      end case;
      
      KartenressourcenDatenbank.KartenressourcenListeArray'Read (Stream (File => DatenbankEinlesen),
                                                       KartenressourcenDatenbank.KartenressourcenListe);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenKartengrundDatenbank;
   
   
   
   procedure EinlesenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/VerbesserungenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/VerbesserungenDatenbank");

         when False =>
            VerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
            return;
      end case;
      
      VerbesserungenDatenbank.VerbesserungenListeArray'Read (Stream (File => DatenbankEinlesen),
                                                             VerbesserungenDatenbank.VerbesserungenListe);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => "Datenbanken/WegeDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/WegeDatenbank");

         when False =>
            VerbesserungenDatenbank.StandardWegeDatenbankLaden;
            return;
      end case;
      
      VerbesserungenDatenbank.WegeListeArray'Read (Stream (File => DatenbankEinlesen),
                                                   VerbesserungenDatenbank.WegeListe);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenVerbesserungenDatenbank;
   
   
   
   procedure EinlesenRassenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/RassenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Datenbanken/RassenDatenbank");

         when False =>
            RassenDatenbank.StandardRassenDatenbankLaden;
            return;
      end case;
      
      RassenDatenbank.RassenListeArray'Read (Stream (File => DatenbankEinlesen),
                                             RassenDatenbank.RassenListe);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenRassenDatenbank;

end EinlesenDatenbanken;
