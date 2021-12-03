pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with GlobaleTexte;
with SystemRecords;

package Eingabe is

   procedure WartenEingabe;
   procedure StandardTastenbelegungLaden;



   function GanzeZahl
     (TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ZeileExtern : in Positive;
      ZahlenMinimumExtern : in Integer;
      ZahlenMaximumExtern : in Integer)
      return SystemRecords.ZahlenEingabeRecord;

   function StadtName
     return Unbounded_Wide_Wide_String;

   function SpielstandName
     return Unbounded_Wide_Wide_String;

   function Tastenwert
     return SystemDatentypen.Tastenbelegung_Enum;

end Eingabe;
