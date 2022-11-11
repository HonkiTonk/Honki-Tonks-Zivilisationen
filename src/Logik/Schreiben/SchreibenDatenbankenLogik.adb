with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;
with VerzeichnisKonstanten;
with ForschungKonstanten;

-- Die Datenbanken wieder einzeln schreiben, damit die Editoren sie auch einzeln schreiben können. äöü
package body SchreibenDatenbankenLogik is
   
   procedure SchreibenAlleDatenbanken
   is begin
      
      SchreibenEinheitenDatenbank;
      SchreibenForschungenDatenbank;
      SchreibenGebäudeDatenbank;
      SchreibenKartenDatenbanken;
      SchreibenVerbesserungenDatenbank;
      SchreibenRassenDatenbank;
      
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
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.BasisgrundDatenbank);
      
      KartenDatenbank.BasisgrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  KartenDatenbank.Basisgrundliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.ZusatzgrundDatenbank);
      
      KartenDatenbank.ZusatzgrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Zusatzgrundliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.KartenFlussDatenbank);
      
      KartenDatenbank.KartenflusslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Kartenflussliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.KartenDatenbank);
      
      KartenDatenbank.KartenressourcenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenDatenbank.Kartenressourcenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenKartenDatenbanken;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                              VerbesserungenDatenbank.Verbesserungenliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.WegeDatenbank);
      
      VerbesserungenDatenbank.WegelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    VerbesserungenDatenbank.Wegeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenVerbesserungenDatenbank;
   
   
   
   procedure SchreibenRassenDatenbank
   is begin
      
      Create (File => DatenbankSpeichern,
              Mode => Out_File,
              Name => VerzeichnisKonstanten.RassenDatenbank);
      
      RassenDatenbank.RassenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                              RassenDatenbank.Rassenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenRassenDatenbank;

end SchreibenDatenbankenLogik;
