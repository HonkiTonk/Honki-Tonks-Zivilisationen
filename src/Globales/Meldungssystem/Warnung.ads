pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package Warnung is
   pragma Elaborate_Body;

   procedure LogikWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 WarnmeldungExtern'Length > 0
              );
   
   procedure GrafikWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 WarnmeldungExtern'Length > 0
              );
   
   procedure MusikWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 WarnmeldungExtern'Length > 0
              );
   
   procedure SoundWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 WarnmeldungExtern'Length > 0
              );
   
end Warnung;
