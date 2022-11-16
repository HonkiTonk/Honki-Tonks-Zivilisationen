with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with RassenDatenbank;
with ForschungKonstanten;
with VerbesserungenDatenbank;

with StandardVerbesserungenDatenbank;
with StandardRassenDatenbank;
with StandardKartenDatenbank;
with StandardGebaeudeDatenbank;
with StandardForschungenDatenbank;
with StandardEinheitenDatenbank;

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
            StandardEinheitenDatenbank.StandardEinheitenDatenbankLaden;
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
            StandardForschungenDatenbank.StandardForschungenDatenbankLaden;
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
            StandardGebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
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
            StandardKartenDatenbank.StandardBasisgrundDatenbankLaden;
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
            StandardKartenDatenbank.StandardZusatzgrundDatenbankLaden;
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
            StandardKartenDatenbank.StandardKartenflussDatenbankLaden;
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
            StandardKartenDatenbank.StandardKartenressourcenDatenbankLaden;
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
            StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
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
            StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
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
            StandardRassenDatenbank.StandardRassenDatenbankLaden;
      end case;
      
   end EinlesenRassenDatenbank;

end EinlesenDatenbankenLogik;
