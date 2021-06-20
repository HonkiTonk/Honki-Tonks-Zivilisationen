pragma SPARK_Mode (On);

with Ada.Directories;
use Ada.Directories;

with EinheitenDatenbank, ForschungsDatenbank, GebaeudeDatenbank, KartenDatenbank, VerbesserungenDatenbank, DatenbankRecords;

package body EinlesenWerte is 
   
   procedure EinlesenAlleDatenbanken
   is begin
      
      EinlesenEinheitenDatenbank;
      EinlesenForschungsDatenbank;
      EinlesenGebäudeDatenbank;
      EinlesenKartenDatenbank;
      EinlesenVerbesserungenDatenbank;
      
   end EinlesenAlleDatenbanken;
   
   
   
   procedure EinlesenEinheitenDatenbank
   is begin
      
      case
        Exists (Name => "Daten/EinheitenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Daten/EinheitenDatenbank");

         when False =>
            return;
      end case;
      
      RassenSchleife:
      for RasseSchleifenwert in EinheitenDatenbank.EinheitenListeArray'Range (1) loop
         EinheitSchleife:
         for EinheitSchleifenwert in EinheitenDatenbank.EinheitenListeArray'Range (2) loop
            
            DatenbankRecords.EinheitenListeRecord'Read (Stream (File => DatenbankEinlesen),
                                                        EinheitenDatenbank.EinheitenListe (RasseSchleifenwert, EinheitSchleifenwert));
            
         end loop EinheitSchleife;
      end loop RassenSchleife;
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenEinheitenDatenbank;
   
   
   
   procedure EinlesenForschungsDatenbank
   is begin
      
      case
        Exists (Name => "Daten/ForschungsDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Daten/ForschungsDatenbank");

         when False =>
            return;
      end case;
      
      RassenSchleife:
      for RasseSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (1) loop
         TechnologieSchleife:
         for TechnologieSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (2) loop
            
            DatenbankRecords.ForschungListeRecord'Read (Stream (File => DatenbankEinlesen),
                                                        ForschungsDatenbank.ForschungListe (RasseSchleifenwert, TechnologieSchleifenwert));
            
         end loop TechnologieSchleife;
      end loop RassenSchleife;
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenForschungsDatenbank;
   
   
   
   procedure EinlesenGebäudeDatenbank
   is begin
      
      case
        Exists (Name => "Daten/GebaeudeDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Daten/GebaeudeDatenbank");

         when False =>
            return;
      end case;
      
      RassenSchleife:
      for RasseSchleifenwert in GebaeudeDatenbank.GebäudeListeArray'Range (1) loop
         GebäudeSchleife:
         for GebäudeSchleifenwert in GebaeudeDatenbank.GebäudeListeArray'Range (2) loop
            
            DatenbankRecords.GebäudeListeRecord'Read (Stream (File => DatenbankEinlesen),
                                                       GebaeudeDatenbank.GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert));
            
         end loop GebäudeSchleife;
      end loop RassenSchleife;
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenGebäudeDatenbank;
   
   
   
   procedure EinlesenKartenDatenbank
   is begin
      
      case
        Exists (Name => "Daten/KartenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Daten/KartenDatenbank");

         when False =>
            return;
      end case;
      
      KartenGrundSchleife:
      for KartenGrundSchleifenwert in KartenDatenbank.KartenListeArray'Range loop
            
         DatenbankRecords.KartenListeRecord'Read (Stream (File => DatenbankEinlesen),
                                                  KartenDatenbank.KartenListe (KartenGrundSchleifenwert));
            
      end loop KartenGrundSchleife;
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenKartenDatenbank;
   
   
   
   procedure EinlesenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => "Daten/VerbesserungenDatenbank")
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => "Daten/VerbesserungenDatenbank");

         when False =>
            return;
      end case;
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in VerbesserungenDatenbank.VerbesserungListeArray'Range loop
            
         DatenbankRecords.VerbesserungListeRecord'Read (Stream (File => DatenbankEinlesen),
                                                        VerbesserungenDatenbank.VerbesserungListe (VerbesserungenSchleifenwert));
            
      end loop VerbesserungenSchleife;
      
      Close (File => DatenbankEinlesen);
      
   end EinlesenVerbesserungenDatenbank;

end EinlesenWerte;
