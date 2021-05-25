pragma SPARK_Mode (On);

with Ada.Directories;
use Ada.Directories;

with Eingabe;

package body Schreiben is

   procedure SchreibenStartAufruf
   is begin

      case
        Exists (Name => "Dateien")
      is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => "Dateien");
      end case;
      
      case
        Exists (Name => "Spielstand")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Spielstand");
      end case;
      
      case
        Exists (Name => "Einstellungen")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Einstellungen");
      end case;

      case
        Exists (Name => "Dateien/Werte")
      is
         when True =>
            Korrekt := WertePrüfen;
            if
              Korrekt = True
            then
               null;
                  
            else
               Schreiben.WerteSchreiben;
            end if;
            
         when False =>
            Schreiben.WerteSchreiben;
      end case;

      case
        Exists (Name => "Dateien/Sprachen")
      is -- Für Deutsch mit in das Programm übernehmen?
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Dateien/Spielstand");
      end case; 
      
      case
        Exists (Name => "Dateien/Einstellungen")
      is
         when True =>
            Korrekt := EinstellungenPrüfen;
            if
              Korrekt = True
            then
               null;
                  
            else
               Schreiben.EinstellungenSchreiben;
            end if;
            
         when False =>
            Schreiben.EinstellungenSchreiben;
      end case;
      
   end SchreibenStartAufruf;
   
   
   
   function WertePrüfen
     return Boolean
   is begin
      
      return True;
      
   end WertePrüfen;



   procedure WerteSchreiben
   is begin
      
      null;
   
   end WerteSchreiben;
   
   

   procedure EinstellungenSchreiben
   is begin
      
      Create (File => EinstellungenDatei,
              Mode => Out_File,
              Name => "Dateien/Einstellungen");
      
   end EinstellungenSchreiben;



   function EinstellungenPrüfen
     return Boolean
   is begin
      
      return True;
      
   end EinstellungenPrüfen;
   
   
   
   procedure TastenbelegungSchreiben
   is begin
      
      Create (File => TastenbelegungSpeichern,
              Mode => Out_File,
              Name => "Einstellungen/Tastenbelegung");
      
      BelegungFeldSchleife:
      for BelegungFeldSchleifenwert in Eingabe.TastenbelegungArray'Range (1) loop
         BelegungPositionSchleife:
         for BelegungPositionSchleifenwert in Eingabe.TastenbelegungArray'Range (2) loop
            
            Wide_Wide_Character'Write (Stream (File => TastenbelegungSpeichern),
                                       Eingabe.Tastenbelegung (BelegungFeldSchleifenwert, BelegungPositionSchleifenwert));
            
         end loop BelegungPositionSchleife;
      end loop BelegungFeldSchleife;      
      
      Close (File => TastenbelegungSpeichern);
      
   end TastenbelegungSchreiben;

end Schreiben;
