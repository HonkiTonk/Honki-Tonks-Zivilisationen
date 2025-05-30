with Ada.Directories;

with TextKonstantenHTSEB;

with SpeziesKonstanten;

with SchreibeGrafiktask;
with LeseSpeziesbelegung;

with TexteingabeLogik;
with LadezeitenLogik;
with UmwandlungenVerzeichnisse;

package body SpielstandAllgemeinesLogik is

   function SpielstandNameErmitteln
     return Unbounded_Wide_Wide_String
   is begin
     
      SchreibeGrafiktask.Spielstandname (JaNeinExtern => True);
      SpielstandName := TexteingabeLogik.SpielstandName;
      SchreibeGrafiktask.Spielstandname (JaNeinExtern => False);
      
      case
        SpielstandName.ErfolgreichAbbruch
      is
         when True =>
            -- Es wird hier keine Prüfung benötigt ob die Namenslänge > 0 ist, da dies schon in TexteingabeLogik.SpielstandName geprüft wird.
            -- Die Prüfung ob der Name kurz genug für das Dateisystem ist erfolgt in TexteingabeGrafik.
            return SpielstandName.EingegebenerText;
            
         when False =>
            return TextKonstantenHTSEB.LeerUnboundedString;
      end case;
            
   end SpielstandNameErmitteln;
   
   
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum)
      return Boolean
   is
      use Ada.Directories;
   begin
      
      return Exists (Name => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => SpielstandartExtern,
                                                                       SpielstandnameExtern => SpielstandnameExtern));
      
   end SpielstandVorhanden;
   
   
   
   procedure FortschrittErhöhen
     (AutospeichernExtern : in Boolean)
   is begin
      
      case
        AutospeichernExtern
      is
         when False =>
            LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => True);
            
         when True =>
            null;
      end case;
      
   end FortschrittErhöhen;
   
   
   
   procedure SpeziesbelegungSchreiben
     (SpeziesbelegungExtern : in SpielRecords.SpeziesbelegungArray)
   is begin
      
      Speziesbelegung := SpeziesbelegungExtern;
      
   end SpeziesbelegungSchreiben;
   
   
   
   function SpeziesbelegungLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return SpeziesDatentypen.Spieler_Enum
   is begin
      
      return Speziesbelegung (SpeziesExtern).Belegung;
      
   end SpeziesbelegungLesen;
   
   
   
   function SpeziesBesiegtLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is begin
      
      return Speziesbelegung (SpeziesExtern).Besiegt;
      
   end SpeziesBesiegtLesen;
   
   
   
   function GesamteSpeziesanzahl
     (SpeichernLadenExtern : in Boolean)
      return SpeziesDatentypen.Speziesnummern
   is begin
      
      VorhandeneSpezies := SpeziesKonstanten.LeerSpeziesnummer;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
               
         if
           SpeichernLadenExtern
           and
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum
         then
            VorhandeneSpezies := VorhandeneSpezies + 1;
                  
         elsif
           (SpeichernLadenExtern = False)
           and
             SpeziesbelegungLesen (SpeziesExtern => SpeziesSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum
         then
            VorhandeneSpezies := VorhandeneSpezies + 1;
               
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return VorhandeneSpezies;
      
   end GesamteSpeziesanzahl;
   
   
   
   function VorhandeneSpeziesanzahl
     (SpeichernLadenExtern : in Boolean)
      return SpeziesDatentypen.Speziesnummern
   is begin
      
      VorhandeneSpezies := SpeziesKonstanten.LeerSpeziesnummer;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
               
         if
           SpeichernLadenExtern
           and
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum
           and
             LeseSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesSchleifenwert) = False
         then
            VorhandeneSpezies := VorhandeneSpezies + 1;
                  
         elsif
           (SpeichernLadenExtern = False)
           and
             SpeziesbelegungLesen (SpeziesExtern => SpeziesSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum
           and
             SpeziesBesiegtLesen (SpeziesExtern => SpeziesSchleifenwert) = False
         then
            VorhandeneSpezies := VorhandeneSpezies + 1;
               
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return VorhandeneSpezies;
      
   end VorhandeneSpeziesanzahl;

end SpielstandAllgemeinesLogik;
