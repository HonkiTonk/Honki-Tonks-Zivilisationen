pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartengrundDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;
with KartenflussDatenbank;
with KartenressourcenDatenbank;

package body EinlesenDatenbankenLogik is
   
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
        Exists (Name => VerzeichnisKonstanten.EinheitenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.EinheitenDatenbank);

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
        Exists (Name => VerzeichnisKonstanten.ForschungenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.ForschungenDatenbank);

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
        Exists (Name => VerzeichnisKonstanten.GebaeudeDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.GebaeudeDatenbank);

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
        Exists (Name => VerzeichnisKonstanten.KartenGrundDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.KartenGrundDatenbank);

         when False =>
            KartengrundDatenbank.StandardKartengrundDatenbankLaden;
            return;
      end case;
      
      KartengrundDatenbank.KartengrundlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                  KartengrundDatenbank.Kartengrundliste);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenFlussDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.KartenFlussDatenbank);

         when False =>
            KartenflussDatenbank.StandardKartenflussDatenbankLaden;
            return;
      end case;
      
      KartenflussDatenbank.KartenflusslisteArray'Read (Stream (File => DatenbankEinlesen),
                                                  KartenflussDatenbank.Kartenflussliste);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenRessourcenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.KartenRessourcenDatenbank);

         when False =>
            KartenressourcenDatenbank.StandardKartenressourcenDatenbankLaden;
            return;
      end case;
      
      KartenressourcenDatenbank.KartenressourcenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                       KartenressourcenDatenbank.Kartenressourcenliste);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenKartengrundDatenbank;
   
   
   
   procedure EinlesenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.VerbesserungenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.WegeDatenbank);

         when False =>
            VerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
            return;
      end case;
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                             VerbesserungenDatenbank.Verbesserungenliste);
      
      Close (File => DatenbankEinlesen);
      
      
      
      case
        Exists (Name => VerzeichnisKonstanten.WegeDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.WegeDatenbank);

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
        Exists (Name => VerzeichnisKonstanten.RassenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.RassenDatenbank);

         when False =>
            RassenDatenbank.StandardRassenDatenbankLaden;
            return;
      end case;
      
      RassenDatenbank.RassenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                             RassenDatenbank.Rassenliste);
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenRassenDatenbank;

end EinlesenDatenbankenLogik;
