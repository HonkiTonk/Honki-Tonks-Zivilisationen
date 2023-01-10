with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with SpeziesDatenbank;
with VerzeichnisKonstanten;
with ForschungKonstanten;

package body SchreibenDatenbankenLogik is
   
   procedure SchreibenAlleDatenbanken
   is begin
      
      SchreibenEinheitenDatenbank;
      SchreibenForschungenDatenbank;
      SchreibenGebäudeDatenbank;
      SchreibenKartenDatenbanken;
      SchreibenVerbesserungenDatenbank;
      SchreibenSpeziesDatenbank;
      
   end SchreibenAlleDatenbanken;
   
   
   
   procedure SchreibenEinheitenDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.EinheitenDatenbank);
      
      EinheitenDatenbank.EinheitenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    EinheitenDatenbank.Einheitenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenEinheitenDatenbank;
   
   
   
   -- Das hier auch noch in einzelne Datenbanken aufteilen? äöü
   procedure SchreibenForschungenDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.ForschungenDatenbank);
      
      ForschungenDatenbank.ForschungslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                       ForschungenDatenbank.Forschungsliste);
      
      ForschungKonstanten.TechnologieVerbesserungenArray'Write (Stream (File => DatenbankSpeichern),
                                                                ForschungenDatenbank.TechnologieVerbesserungen);
      
      ForschungKonstanten.TechnologieWegeArray'Write (Stream (File => DatenbankSpeichern),
                                                      ForschungenDatenbank.TechnologieWege);
      
      ForschungKonstanten.TechnologieUmgebungsgrößeArray'Write (Stream (File => DatenbankSpeichern),
                                                                  ForschungenDatenbank.TechnologieUmgebungsgröße);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenForschungenDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.GebaeudeDatenbank);
      
      GebaeudeDatenbank.GebäudelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  GebaeudeDatenbank.Gebäudeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbanken
   is begin
      
      SchreibeBasisgrund;
      SchreibeZusatzgrund;
      SchreibeFluss;
      SchreibeRessourcen;
      
   end SchreibenKartenDatenbanken;
   
   
   
   procedure SchreibeBasisgrund
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.BasisgrundDatenbank);
      
      KartenDatenbank.BasisgrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  KartenDatenbank.Basisgrundliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibeBasisgrund;
   
      
   
   procedure SchreibeZusatzgrund
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.ZusatzgrundDatenbank);
      
      KartenDatenbank.ZusatzgrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Zusatzgrundliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibeZusatzgrund;
   
   
   
   procedure SchreibeFluss
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.KartenFlussDatenbank);
      
      KartenDatenbank.KartenflusslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Kartenflussliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibeFluss;
   
   
   
   procedure SchreibeRessourcen
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.KartenDatenbank);
      
      KartenDatenbank.KartenressourcenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenDatenbank.Kartenressourcenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibeRessourcen;
   
      
      
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      SchreibeVerbesserungen;
      SchreibeWege;
      
   end SchreibenVerbesserungenDatenbank;
   
   
   
   procedure SchreibeVerbesserungen
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                              VerbesserungenDatenbank.Verbesserungenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibeVerbesserungen;
   
   
      
   procedure SchreibeWege
   is begin
         
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.WegeDatenbank);
      
      VerbesserungenDatenbank.WegelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    VerbesserungenDatenbank.Wegeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibeWege;
      
         
   
   procedure SchreibenSpeziesDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.SpeziesDatenbank);
      
      SpeziesDatenbank.SpezieslisteArray'Write (Stream (File => DatenbankSpeichern),
                                              SpeziesDatenbank.Speziesliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenSpeziesDatenbank;

end SchreibenDatenbankenLogik;
