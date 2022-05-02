pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with SystemRecords;
with TastenbelegungDatentypen;

package Eingabe is

   procedure WartenEingabe;
   procedure StandardTastenbelegungLaden;



   function GanzeZahl
     (ZeileExtern : in Positive;
      ZahlenMinimumExtern : in SystemDatentypen.Grenzen;
      ZahlenMaximumExtern : in SystemDatentypen.Grenzen)
      return SystemRecords.ZahlenEingabeRecord;

   function StadtName
     return SystemRecords.TextEingabeRecord;

   function SpielstandName
     return SystemRecords.TextEingabeRecord;

   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum;

end Eingabe;
