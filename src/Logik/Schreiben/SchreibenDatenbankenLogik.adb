with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with SpeziesDatenbank;
with VerzeichnisKonstanten;
with ForschungRecordKonstanten;

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
              Name => VerzeichnisKonstanten.EinheitenDatenbank,
              Form => "WCEM=8");
      
      EinheitenDatenbank.EinheitenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    EinheitenDatenbank.Einheitenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenEinheitenDatenbank;
   
   
   
   -- Das hier auch noch in einzelne Datenbanken aufteilen? äöü
   procedure SchreibenForschungenDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.ForschungenDatenbank,
              Form => "WCEM=8");
      
      ForschungenDatenbank.ForschungslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                       ForschungenDatenbank.Forschungsliste);
      
      ForschungRecordKonstanten.TechnologieVerbesserungenArray'Write (Stream (File => DatenbankSpeichern),
                                                                      ForschungenDatenbank.TechnologieVerbesserungen);
      
      ForschungRecordKonstanten.TechnologieWegeArray'Write (Stream (File => DatenbankSpeichern),
                                                            ForschungenDatenbank.TechnologieWege);
      
      ForschungRecordKonstanten.TechnologieUmgebungsgrößeArray'Write (Stream (File => DatenbankSpeichern),
                                                                        ForschungenDatenbank.TechnologieUmgebungsgröße);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenForschungenDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.GebaeudeDatenbank,
              Form => "WCEM=8");
      
      GebaeudeDatenbank.GebäudelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  GebaeudeDatenbank.Gebäudeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbanken
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.KartenDatenbank,
              Form => "WCEM=8");
            
      KartenDatenbank.BasisgrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  KartenDatenbank.Basisgrundliste);
      
      KartenDatenbank.ZusatzgrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Zusatzgrundliste);
      
      KartenDatenbank.KartenflusslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Kartenflussliste);
      
      KartenDatenbank.KartenressourcenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenDatenbank.Kartenressourcenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenKartenDatenbanken;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.VerbesserungenDatenbank,
              Form => "WCEM=8");
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                              VerbesserungenDatenbank.Verbesserungenliste);
      
      VerbesserungenDatenbank.WegelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    VerbesserungenDatenbank.Wegeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenVerbesserungenDatenbank;
      
         
   
   procedure SchreibenSpeziesDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.SpeziesDatenbank,
              Form => "WCEM=8");
      
      SpeziesDatenbank.SpezieslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                SpeziesDatenbank.Speziesliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenSpeziesDatenbank;

end SchreibenDatenbankenLogik;
