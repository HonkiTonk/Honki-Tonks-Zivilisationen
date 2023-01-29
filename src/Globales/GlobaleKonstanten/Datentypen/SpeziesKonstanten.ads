with SpeziesDatentypen;

package SpeziesKonstanten is
   pragma Pure;
   
   LeerSpezies : constant SpeziesDatentypen.Spezies_Enum := SpeziesDatentypen.Leer_Spezies_Enum;

   LeerSpeziesnummer : constant Natural := SpeziesDatentypen.Speziesnummern'First;
   
   Speziesanfang : constant Positive := SpeziesDatentypen.SpeziesnummernVorhanden'First;
   Speziesende : constant Positive := SpeziesDatentypen.SpeziesnummernVorhanden'Last;
   
   -- Die Spezien auch mal in einzelne Konstanten packen? äöü

end SpeziesKonstanten;
