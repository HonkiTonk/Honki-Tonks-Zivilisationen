pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with ZahlenDatentypen;

package InteraktionEingabe is

   TastenEingabe : Boolean := False;
   TextEingabe : Boolean := False;
   
   JaNeinFrage : ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   
   Eingabe : SystemDatentypen.Welche_Eingabe_Enum := SystemDatentypen.Keine_Eingabe_Enum;

end InteraktionEingabe;
