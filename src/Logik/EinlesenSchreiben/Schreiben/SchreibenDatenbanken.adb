pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with EinheitenDatenbank;
with ForschungsDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;

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
      
      EinheitenDatenbank.EinheitenListeArray'Write (Stream (File => DatenbankSpeichern),
                                                    EinheitenDatenbank.EinheitenListe);
      
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
      
      ForschungsDatenbank.ForschungListeArray'Write (Stream (File => DatenbankSpeichern),
                                                     ForschungsDatenbank.ForschungListe);
      
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
      
      GebaeudeDatenbank.GebäudeListeArray'Write (Stream (File => DatenbankSpeichern),
                                                  GebaeudeDatenbank.GebäudeListe);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/KartenGrundDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/KartenGrundDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/KartenGrundDatenbank");
      end case;
      
      KartenDatenbank.KartenGrundListeArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.KartenGrundListe);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => "Einstellungen/KartenFlussDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/KartenFlussDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/KartenFlussDatenbank");
      end case;
      
      KartenDatenbank.KartenFlussListeArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.KartenFlussListe);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => "Einstellungen/KartenRessourcenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/KartenRessourcenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/KartenRessourcenDatenbank");
      end case;
      
      KartenDatenbank.KartenRessourcenListeArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenDatenbank.KartenRessourcenListe);
      
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
      
      VerbesserungenDatenbank.VerbesserungListeArray'Write (Stream (File => DatenbankSpeichern),
                                                            VerbesserungenDatenbank.VerbesserungListe);
      
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
      
      RassenDatenbank.RassenListeArray'Write (Stream (File => DatenbankSpeichern),
                                              RassenDatenbank.RassenListe);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenRassenDatenbank;

end SchreibenDatenbanken;
