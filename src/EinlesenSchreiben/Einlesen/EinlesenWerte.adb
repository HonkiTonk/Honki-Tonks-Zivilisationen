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
            null;

         when False =>
            return;
      end case;
      
      Open (File => EinheitenDatenbankEinlesen,
            Mode => In_File,
            Name => "Daten/EinheitenDatenbank");
      
      RassenSchleife:
      for RasseSchleifenwert in EinheitenDatenbank.EinheitenListeArray'Range (1) loop
         EinheitSchleife:
         for EinheitSchleifenwert in EinheitenDatenbank.EinheitenListeArray'Range (2) loop
            
            DatenbankRecords.EinheitenListeRecord'Read (Stream (File => EinheitenDatenbankEinlesen),
                                                        EinheitenDatenbank.EinheitenListe (RasseSchleifenwert, EinheitSchleifenwert));
            
         end loop EinheitSchleife;
      end loop RassenSchleife;
      
      Close (File => EinheitenDatenbankEinlesen);
      
   end EinlesenEinheitenDatenbank;
   
   
   
   procedure EinlesenForschungsDatenbank
   is begin
      
      case
        Exists (Name => "Daten/ForschungsDatenbank")
      is
         when True =>
            null;

         when False =>
            return;
      end case;
      
      Open (File => ForschungsDatenbankEinlesen,
            Mode => In_File,
            Name => "Daten/ForschungsDatenbank");
      
      RassenSchleife:
      for RasseSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (1) loop
         TechnologieSchleife:
         for TechnologieSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (2) loop
            
            DatenbankRecords.ForschungListeRecord'Read (Stream (File => ForschungsDatenbankEinlesen),
                                                        ForschungsDatenbank.ForschungListe (RasseSchleifenwert, TechnologieSchleifenwert));
            
         end loop TechnologieSchleife;
      end loop RassenSchleife;
      
      Close (File => ForschungsDatenbankEinlesen);
      
   end EinlesenForschungsDatenbank;
   
   
   
   procedure EinlesenGebäudeDatenbank
   is begin
      
      case
        Exists (Name => "Daten/GebaeudeDatenbank")
      is
         when True =>
            null;

         when False =>
            return;
      end case;
      
      Open (File => GebäudeDatenbankEinlesen,
            Mode => In_File,
            Name => "Daten/GebaeudeDatenbank");
      
      RassenSchleife:
      for RasseSchleifenwert in GebaeudeDatenbank.GebäudeListeArray'Range (1) loop
         GebäudeSchleife:
         for GebäudeSchleifenwert in GebaeudeDatenbank.GebäudeListeArray'Range (2) loop
            
            DatenbankRecords.GebäudeListeRecord'Read (Stream (File => GebäudeDatenbankEinlesen),
                                                       GebaeudeDatenbank.GebäudeListe (RasseSchleifenwert, GebäudeSchleifenwert));
            
         end loop GebäudeSchleife;
      end loop RassenSchleife;
      
      Close (File => GebäudeDatenbankEinlesen);
      
   end EinlesenGebäudeDatenbank;
   
   
   
   procedure EinlesenKartenDatenbank
   is begin
      
      case
        Exists (Name => "Daten/KartenDatenbank")
      is
         when True =>
            null;

         when False =>
            return;
      end case;
      
      Open (File => KartenDatenbankEinlesen,
            Mode => In_File,
            Name => "Daten/KartenDatenbank");
      
      KartenGrundSchleife:
      for KartenGrundSchleifenwert in KartenDatenbank.KartenListeArray'Range loop
            
         DatenbankRecords.KartenListeRecord'Read (Stream (File => KartenDatenbankEinlesen),
                                                  KartenDatenbank.KartenListe (KartenGrundSchleifenwert));
            
      end loop KartenGrundSchleife;
      
      Close (File => KartenDatenbankEinlesen);
      
   end EinlesenKartenDatenbank;
   
   
   
   procedure EinlesenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => "Daten/VerbesserungenDatenbank")
      is
         when True =>
            null;

         when False =>
            return;
      end case;
      
      Open (File => VerbesserungenDatenbankEinlesen,
            Mode => In_File,
            Name => "Daten/VerbesserungenDatenbank");
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in VerbesserungenDatenbank.VerbesserungListeArray'Range loop
            
         DatenbankRecords.VerbesserungListeRecord'Read (Stream (File => VerbesserungenDatenbankEinlesen),
                                                        VerbesserungenDatenbank.VerbesserungListe (VerbesserungenSchleifenwert));
            
      end loop VerbesserungenSchleife;
      
      Close (File => VerbesserungenDatenbankEinlesen);
      
   end EinlesenVerbesserungenDatenbank;

end EinlesenWerte;
