with Ada.Directories;

with TextKonstantenHTSEB;

with SchreibeGrafiktask;

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

end SpielstandAllgemeinesLogik;
