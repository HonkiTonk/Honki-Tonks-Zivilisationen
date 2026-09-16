private with RueckgabeDatentypen;
private with KartenRecords;

package KartenformEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenform;
   
private
   
   KartenformAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   KartenformEingestellt : KartenRecords.KartenformRecord;
   KartenformNeu : KartenRecords.KartenformRecord;
   
   procedure KartenformZuweisen
     (WelchEbeneExtern : in RueckgabeDatentypen.Kartenform_Enum);

end KartenformEinstellenLogik;
