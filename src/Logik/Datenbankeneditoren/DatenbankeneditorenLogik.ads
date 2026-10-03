with RueckgabeDatentypen;

package DatenbankeneditorenLogik is
   pragma Elaborate_Body;

   function DatenbankenEditoren
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   Kartendatenbank : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Einheitendatenbank : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Kartendatenbank);
   Gebäudedatenbank : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Einheitendatenbank);
   Forschungsdatenbank : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Gebäudedatenbank);
   Verbesserungendatenbank : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Forschungsdatenbank);
   Standardwerte : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Verbesserungendatenbank);

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure AlleAufStandard;

end DatenbankeneditorenLogik;
