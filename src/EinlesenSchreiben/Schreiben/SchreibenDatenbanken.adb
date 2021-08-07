pragma SPARK_Mode (On);

with Ada.Directories;
use Ada.Directories;

with EinheitenDatenbank, ForschungsDatenbank, GebaeudeDatenbank, KartenDatenbank, VerbesserungenDatenbank, RassenDatenbank, DatenbankRecords;

package body SchreibenDatenbanken is
   
   procedure SchreibenAlleDatenbanken
   is begin
      
      SchreibenEinheitenDatenbank;
      SchreibenForschungsDatenbank;
      SchreibenGebäudeDatenbank;
      SchreibenKartenDatenbank;
      SchreibenVerbesserungenDatenbank;
      SchreibenRassenDatenbank;
      
   end SchreibenAlleDatenbanken;
   
   
   
   procedure SchreibenEinheitenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/EinheitenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/EinheitenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/EinheitenDatenbank");
      end case;
      
      RassenSchleife:
      for RasseSchleifenwert in EinheitenDatenbank.EinheitenListeArray'Range (1) loop
         EinheitSchleife:
         for EinheitSchleifenwert in EinheitenDatenbank.EinheitenListeArray'Range (2) loop
            
            DatenbankRecords.EinheitenListeRecord'Write (Stream (File => DatenbankSpeichern),
                                                         EinheitenDatenbank.EinheitenListe (RasseSchleifenwert, EinheitSchleifenwert));
            
         end loop EinheitSchleife;
      end loop RassenSchleife;
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenEinheitenDatenbank;
   
   
   
   procedure SchreibenForschungsDatenbank
   is begin
      case
        Exists (Name => "Einstellungen/ForschungsDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/ForschungsDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/ForschungsDatenbank");
      end case;      
      
      RassenSchleife:
      for RasseSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (1) loop
         TechnologieSchleife:
         for TechnologieSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (2) loop
            
            DatenbankRecords.ForschungListeRecord'Write (Stream (File => DatenbankSpeichern),
                                                         ForschungsDatenbank.ForschungListe (RasseSchleifenwert, TechnologieSchleifenwert));
            
         end loop TechnologieSchleife;
      end loop RassenSchleife;
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenForschungsDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/GebaeudeDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/GebaeudeDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/GebaeudeDatenbank");
      end case;
      
      RassenSchleife:
      for RasseSchleifenwert in GebaeudeDatenbank.GebäudeListeArray'Range (1) loop
         GebäudeSchleife:
         for GebäudeSchleifenwert in GebaeudeDatenbank.GebäudeListeArray'Range (2) loop
            
            DatenbankRecords.GebäudeListeRecord'Write (Stream (File => DatenbankSpeichern),
                                                        GebaeudeDatenbank.GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert));
            
         end loop GebäudeSchleife;
      end loop RassenSchleife;
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/KartenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/KartenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/KartenDatenbank");
      end case;
      
      KartenGrundSchleife:
      for KartenGrundSchleifenwert in KartenDatenbank.KartenListeArray'Range loop
            
         DatenbankRecords.KartenListeRecord'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.KartenListe (KartenGrundSchleifenwert));
            
      end loop KartenGrundSchleife;
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenKartenDatenbank;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/VerbesserungenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/VerbesserungenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/VerbesserungenDatenbank");
      end case;
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in VerbesserungenDatenbank.VerbesserungListeArray'Range loop
            
         DatenbankRecords.VerbesserungListeRecord'Write (Stream (File => DatenbankSpeichern),
                                                         VerbesserungenDatenbank.VerbesserungListe (VerbesserungenSchleifenwert));
            
      end loop VerbesserungenSchleife;
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenVerbesserungenDatenbank;
   
   
   
   procedure SchreibenRassenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/RassenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/RassenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/RassenDatenbank");
      end case;
      
      RassenSchleife:
      for RassenSchleifenwert in RassenDatenbank.RassenListeArray'Range loop
            
         DatenbankRecords.RassenListeRecord'Write (Stream (File => DatenbankSpeichern),
                                                   RassenDatenbank.RassenListe (RassenSchleifenwert));
            
      end loop RassenSchleife;
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenRassenDatenbank;

end SchreibenDatenbanken;
