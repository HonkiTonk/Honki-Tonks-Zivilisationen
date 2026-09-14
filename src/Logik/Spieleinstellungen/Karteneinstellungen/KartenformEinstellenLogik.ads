private with RueckgabeDatentypen;

package KartenformEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenform;
   
private
   
   KartenformAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   procedure KartenformZuweisen
     (WelchEbeneExtern : in RueckgabeDatentypen.Kartenform_Enum);

end KartenformEinstellenLogik;
