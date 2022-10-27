pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;
with ForschungKonstanten;

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
      
            EinheitenDatenbank.EinheitenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                         EinheitenDatenbank.Einheitenliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            EinheitenDatenbank.StandardEinheitenDatenbankLaden;
      end case;
      
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
      
            ForschungenDatenbank.ForschungslisteArray'Read (Stream (File => DatenbankEinlesen),
                                                            ForschungenDatenbank.Forschungsliste);
      
            ForschungKonstanten.TechnologieVerbesserungenArray'Read (Stream (File => DatenbankEinlesen),
                                                                     ForschungenDatenbank.TechnologieVerbesserungen);
      
            ForschungKonstanten.TechnologieWegeArray'Read (Stream (File => DatenbankEinlesen),
                                                           ForschungenDatenbank.TechnologieWege);
      
            ForschungKonstanten.TechnologieUmgebungsgrößeArray'Read (Stream (File => DatenbankEinlesen),
                                                                       ForschungenDatenbank.TechnologieUmgebungsgröße);
      
            Close (File => DatenbankEinlesen);

         when False =>
            ForschungenDatenbank.StandardForschungenDatenbankLaden;
      end case;
      
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
      
            GebaeudeDatenbank.GebäudelisteArray'Read (Stream (File => DatenbankEinlesen),
                                                       GebaeudeDatenbank.Gebäudeliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            GebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
      end case;
      
   end EinlesenGebäudeDatenbank;
   
   
   
   procedure EinlesenKartengrundDatenbank
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.BasisgrundDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.BasisgrundDatenbank);
      
            KartenDatenbank.BasisgrundlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                       KartenDatenbank.Basisgrundliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            KartenDatenbank.StandardBasisgrundDatenbankLaden;
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.ZusatzgrundDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.ZusatzgrundDatenbank);
      
            KartenDatenbank.ZusatzgrundlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                        KartenDatenbank.Zusatzgrundliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            KartenDatenbank.StandardZusatzgrundDatenbankLaden;
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenFlussDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.KartenFlussDatenbank);
      
            KartenDatenbank.KartenflusslisteArray'Read (Stream (File => DatenbankEinlesen),
                                                        KartenDatenbank.Kartenflussliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            KartenDatenbank.StandardKartenflussDatenbankLaden;
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.KartenDatenbank);
      
            KartenDatenbank.KartenressourcenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                             KartenDatenbank.Kartenressourcenliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            KartenDatenbank.StandardKartenressourcenDatenbankLaden;
      end case;
      
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
      
            VerbesserungenDatenbank.VerbesserungenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                                   VerbesserungenDatenbank.Verbesserungenliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            VerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.WegeDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.WegeDatenbank);
      
            VerbesserungenDatenbank.WegelisteArray'Read (Stream (File => DatenbankEinlesen),
                                                         VerbesserungenDatenbank.Wegeliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            VerbesserungenDatenbank.StandardWegeDatenbankLaden;
      end case;
      
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
      
            RassenDatenbank.RassenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                   RassenDatenbank.Rassenliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            RassenDatenbank.StandardRassenDatenbankLaden;
      end case;
      
   end EinlesenRassenDatenbank;

end EinlesenDatenbankenLogik;
