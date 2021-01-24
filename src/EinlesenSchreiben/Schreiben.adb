package body Schreiben is

   procedure SchreibenStartAufruf is
   begin

      case Exists (Name => "Dateien") is
         when True =>
            null;
            
         when False =>
            Create_Directory (New_Directory => "Dateien");
      end case;


      
      case Exists (Name => "Dateien/Spielstand") is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Dateien/Spielstand");
      end case;



      case Exists (Name => "Dateien/Werte") is
         when True =>
            Korrekt := WertePrüfen;
            case Korrekt is
               when True =>
                  null;
                  
               when False =>
                  Schreiben.WerteSchreiben;
            end case;
            
         when False =>
            Schreiben.WerteSchreiben;
      end case;



      case Exists (Name => "Dateien/Sprachen") is -- Für Deutsch mit in das Programm übernehmen?
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Dateien/Spielstand");
      end case;

 
      
      case Exists (Name => "Dateien/Einstellungen") is
         when True =>
            Korrekt := EinstellungenPrüfen;
            case Korrekt is
               when True =>
                  null;
                  
               when False =>
                  Schreiben.EinstellungenSchreiben;
            end case;
            
         when False =>
            Schreiben.EinstellungenSchreiben;
      end case;
      
   end SchreibenStartAufruf;
   
   
   
   function WertePrüfen return Boolean is
   begin
      
      return True;
      
   end WertePrüfen;



   procedure WerteSchreiben is
   begin
      
      null;
   
   end WerteSchreiben;
   
   

   procedure EinstellungenSchreiben is
   begin
      
      Create (File => EinstellungenDatei,
              Mode => Out_File,
              Name => "Dateien/Einstellungen");
      
   end EinstellungenSchreiben;



   function EinstellungenPrüfen return Boolean is
   begin
      
      return True;
      
   end EinstellungenPrüfen;

end Schreiben;
