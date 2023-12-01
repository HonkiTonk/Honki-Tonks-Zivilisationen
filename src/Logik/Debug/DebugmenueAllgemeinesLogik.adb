with SpeziesKonstanten;

with ZahleneingabeLogik;

package body DebugmenueAllgemeinesLogik is

   -- Immer dran denken, das hier prüft auch ob die Belegung der Spezies leer ist.
   function SpeziesAuswählen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return SpeziesDatentypen.Spezies_Enum
   is 
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Zahleneingabe := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => SpeziesKonstanten.Speziesanfang,
                                                         ZahlenMaximumExtern => SpeziesKonstanten.Speziesende,
                                                         WelcheFrageExtern   => 1);
                     
      case
        Zahleneingabe.ErfolgreichAbbruch
      is
         when False =>
            return SpeziesDatentypen.Leer_Spezies_Enum;
            
         when True =>
            AusgewählteSpezies := SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (Zahleneingabe.EingegebeneZahl);
      end case;
      
      if
        SpeziesExtern = AusgewählteSpezies
      then
         return SpeziesDatentypen.Leer_Spezies_Enum;
         
      elsif
        LeseSpeziesbelegung.Belegung (SpeziesExtern => AusgewählteSpezies) = SpeziesDatentypen.Leer_Spieler_Enum
      then
         return SpeziesDatentypen.Leer_Spezies_Enum;
         
      else
         return AusgewählteSpezies;
      end if;
      
   end SpeziesAuswählen;
   
   
   
   function DiplomatiestatusAuswählen
     return DiplomatieDatentypen.Status_Untereinander_Enum
   is begin
      
      Zahleneingabe := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => DiplomatieDatentypen.Status_Untereinander_Enum'Pos (DiplomatieDatentypen.Status_Untereinander_Enum'First),
                                                         ZahlenMaximumExtern => DiplomatieDatentypen.Status_Untereinander_Enum'Pos (DiplomatieDatentypen.Status_Untereinander_Enum'Last),
                                                         WelcheFrageExtern   => 2);
      
      case
        Zahleneingabe.ErfolgreichAbbruch
      is
         when False =>
            return DiplomatieDatentypen.Neutral_Enum;
            
         when True =>
            return DiplomatieDatentypen.Status_Untereinander_Enum'Val (Zahleneingabe.EingegebeneZahl);
      end case;
      
   end DiplomatiestatusAuswählen;

end DebugmenueAllgemeinesLogik;
