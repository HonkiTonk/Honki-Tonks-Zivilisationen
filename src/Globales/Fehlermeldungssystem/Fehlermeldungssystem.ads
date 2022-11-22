package Fehlermeldungssystem is
   pragma Elaborate_Body;
   
   procedure Logik
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 FehlermeldungExtern'Length > 0
              );
            
   procedure Grafik
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 FehlermeldungExtern'Length > 0
              );
   
   procedure Musik
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 FehlermeldungExtern'Length > 0
              );
   
   procedure Sound
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 FehlermeldungExtern'Length > 0
              );
   
private
   
   LogikStopp : exception;
   GrafikStopp : exception;
   MusikStopp : exception;
   SoundStopp : exception;

end Fehlermeldungssystem;
