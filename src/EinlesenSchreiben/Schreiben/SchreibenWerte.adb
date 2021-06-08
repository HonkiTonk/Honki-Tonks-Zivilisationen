pragma SPARK_Mode (On);

with EinheitenDatenbank, ForschungsDatenbank, GebaeudeDatenbank, KartenDatenbank, VerbesserungenDatenbank, DatenbankRecords;

package body SchreibenWerte is
   
   procedure SchreibenAlleDatenbanken
   is begin
      
      SchreibenEinheitenDatenbank;
      SchreibenForschungsDatenbank;
      SchreibenGebäudeDatenbank;
      SchreibenKartenDatenbank;
      SchreibenVerbesserungenDatenbank;
      
   end SchreibenAlleDatenbanken;
   
   
   
   procedure SchreibenEinheitenDatenbank
   is begin
      
      Create (File => EinheitenDatenbankSpeichern,
              Mode => Out_File,
              Name => "Daten/EinheitenDatenbank");
      
      Open (File => EinheitenDatenbankSpeichern,
            Mode => In_File,
            Name => "Daten/EinheitenDatenbank");
      
      RassenSchleife:
      for RasseSchleifenwert in EinheitenDatenbank.EinheitenListeArray'Range (1) loop
         EinheitSchleife:
         for EinheitSchleifenwert in EinheitenDatenbank.EinheitenListeArray'Range (2) loop
            
            DatenbankRecords.EinheitenListeRecord'Write (Stream (File => EinheitenDatenbankSpeichern),
                                                         EinheitenDatenbank.EinheitenListe (RasseSchleifenwert, EinheitSchleifenwert));
            
         end loop EinheitSchleife;
      end loop RassenSchleife;
      
      Close (File => EinheitenDatenbankSpeichern);
      
   end SchreibenEinheitenDatenbank;
   
   
   
   procedure SchreibenForschungsDatenbank
   is begin
      
      Create (File => ForschungsDatenbankSpeichern,
              Mode => Out_File,
              Name => "Daten/ForschungsDatenbank");
      
      Open (File => ForschungsDatenbankSpeichern,
            Mode => In_File,
            Name => "Daten/ForschungsDatenbank");
      
      RassenSchleife:
      for RasseSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (1) loop
         TechnologieSchleife:
         for TechnologieSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (2) loop
            
            DatenbankRecords.ForschungListeRecord'Write (Stream (File => ForschungsDatenbankSpeichern),
                                                         ForschungsDatenbank.ForschungListe (RasseSchleifenwert, TechnologieSchleifenwert));
            
         end loop TechnologieSchleife;
      end loop RassenSchleife;
      
      Close (File => ForschungsDatenbankSpeichern);
      
   end SchreibenForschungsDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      Create (File => GebäudeDatenbankSpeichern,
              Mode => Out_File,
              Name => "Daten/GebaeudeDatenbank");
      
      Open (File => GebäudeDatenbankSpeichern,
            Mode => In_File,
            Name => "Daten/GebaeudeDatenbank");
      
      RassenSchleife:
      for RasseSchleifenwert in GebaeudeDatenbank.GebäudeListeArray'Range (1) loop
         GebäudeSchleife:
         for GebäudeSchleifenwert in GebaeudeDatenbank.GebäudeListeArray'Range (2) loop
            
            DatenbankRecords.GebäudeListeRecord'Write (Stream (File => GebäudeDatenbankSpeichern),
                                                        GebaeudeDatenbank.GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert));
            
         end loop GebäudeSchleife;
      end loop RassenSchleife;
      
      Close (File => GebäudeDatenbankSpeichern);
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbank
   is begin
      
      Create (File => KartenDatenbankSpeichern,
              Mode => Out_File,
              Name => "Daten/KartenDatenbank");
      
      Open (File => KartenDatenbankSpeichern,
            Mode => In_File,
            Name => "Daten/KartenDatenbank");
      
      KartenGrundSchleife:
      for KartenGrundSchleifenwert in KartenDatenbank.KartenListeArray'Range loop
            
         DatenbankRecords.KartenListeRecord'Write (Stream (File => KartenDatenbankSpeichern),
                                                   KartenDatenbank.KartenListe (KartenGrundSchleifenwert));
            
      end loop KartenGrundSchleife;
      
      Close (File => KartenDatenbankSpeichern);
      
   end SchreibenKartenDatenbank;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      Create (File => VerbesserungenDatenbankSpeichern,
              Mode => Out_File,
              Name => "Daten/VerbesserungenDatenbank");
      
      Open (File => VerbesserungenDatenbankSpeichern,
            Mode => In_File,
            Name => "Daten/VerbesserungenDatenbank");
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in VerbesserungenDatenbank.VerbesserungListeArray'Range loop
            
         DatenbankRecords.VerbesserungListeRecord'Write (Stream (File => VerbesserungenDatenbankSpeichern),
                                                         VerbesserungenDatenbank.VerbesserungListe (VerbesserungenSchleifenwert));
            
      end loop VerbesserungenSchleife;
      
      Close (File => VerbesserungenDatenbankSpeichern);
      
   end SchreibenVerbesserungenDatenbank;

end SchreibenWerte;
