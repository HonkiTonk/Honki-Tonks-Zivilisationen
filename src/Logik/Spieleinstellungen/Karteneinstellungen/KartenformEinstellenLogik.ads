private with RueckgabeDatentypen;
private with KartenRecords;

package KartenformEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenform;
   
private
   
   ObereEbene : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   UntereEbene : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (ObereEbene);
   Norden : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (UntereEbene);
   Süden : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Norden);
   Westen : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Süden);
   Osten : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Westen);
   Zufall : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Osten);
   Standardform : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Zufall);
   
   KartenformAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   KartenformEingestellt : KartenRecords.KartenformRecord;
   KartenformNeu : KartenRecords.KartenformRecord;
   
   procedure KartenformZuweisen
     (WelchEbeneExtern : in RueckgabeDatentypen.Kartenform_Enum);

end KartenformEinstellenLogik;
