with SpeziesDatentypen;

package SpeziesKonstanten is
   pragma Pure;
   
   LeerSpezies : constant SpeziesDatentypen.Spezies_Enum := SpeziesDatentypen.Keine_Spezies_Enum;

   LeerSpeziesnummer : constant Natural := SpeziesDatentypen.Speziesnummern'First;
   
   Speziesanfang : constant Positive := SpeziesDatentypen.SpeziesnummernVorhanden'First;
   Speziesende : constant Positive := SpeziesDatentypen.SpeziesnummernVorhanden'Last;

end SpeziesKonstanten;
