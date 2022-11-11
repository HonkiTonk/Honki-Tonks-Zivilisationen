private with RueckgabeDatentypen;

package HauptmenueLogik is
   pragma Elaborate_Body;

   procedure Hauptmenü;
   
private
  
   RückgabeAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeKampagne : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end HauptmenueLogik;
