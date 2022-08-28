pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with TextKonstanten;

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
        Exists (Name => TextKonstanten.EinheitenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.EinheitenDatenbank);

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
        Exists (Name => TextKonstanten.ForschungenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.ForschungenDatenbank);

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
        Exists (Name => TextKonstanten.GebaeudeDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.GebaeudeDatenbank);

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
        Exists (Name => TextKonstanten.KartenGrundDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.KartenGrundDatenbank);

         when False =>
            KartengrundDatenbank.StandardKartengrundDatenbankLaden;
            return;
      end case;
      
      KartengrundDatenbank.KartengrundlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                  KartengrundDatenbank.Kartengrundliste);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => TextKonstanten.KartenFlussDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.KartenFlussDatenbank);

         when False =>
            KartenflussDatenbank.StandardKartenflussDatenbankLaden;
            return;
      end case;
      
      KartenflussDatenbank.KartenflusslisteArray'Read (Stream (File => DatenbankEinlesen),
                                                  KartenflussDatenbank.Kartenflussliste);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => TextKonstanten.KartenRessourcenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.KartenRessourcenDatenbank);

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
        Exists (Name => TextKonstanten.VerbesserungenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.WegeDatenbank);

         when False =>
            VerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
            return;
      end case;
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                             VerbesserungenDatenbank.Verbesserungenliste);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => TextKonstanten.WegeDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.WegeDatenbank);

         when False =>
            VerbesserungenDatenbank.StandardWegeDatenbankLaden;
            return;
      end case;
      
      VerbesserungenDatenbank.WegelisteArray'Read (Stream (File => DatenbankEinlesen),
                                                   VerbesserungenDatenbank.Wegeliste);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenVerbesserungenDatenbank;
   
   
   
   procedure EinlesenRassenDatenbank
   is begin
      
      case
        Exists (Name => TextKonstanten.RassenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => TextKonstanten.RassenDatenbank);

         when False =>
            RassenDatenbank.StandardRassenDatenbankLaden;
            return;
      end case;
      
      RassenDatenbank.RassenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                             RassenDatenbank.Rassenliste);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenRassenDatenbank;

end EinlesenDatenbanken;
