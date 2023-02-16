with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with FehlermeldungSchreiben;
with DebugobjekteLogik;

package body Fehlermeldungssystem is

   procedure Logik
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Logikfehler: " & FehlermeldungExtern);
      
      case
        DebugobjekteLogik.Debug.FehlerWarnung
      is
         when True =>
            Put_Line (Item => "Logikfehler: " & FehlermeldungExtern);
            raise LogikStopp;
            
         when False =>
            null;
      end case;
      
   end Logik;
   
   
   
   procedure Grafik
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
         
      FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Grafikfehler: " & FehlermeldungExtern);
      
      case
        DebugobjekteLogik.Debug.FehlerWarnung
      is
         when True =>
            Put_Line (Item => "Grafikfehler: " & FehlermeldungExtern);
            raise GrafikStopp;
            
         when False =>
            null;
      end case;
      
   end Grafik;
   
   
   
   procedure Musik
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Musikfehler: " & FehlermeldungExtern);
      
      case
        DebugobjekteLogik.Debug.FehlerWarnung
      is
         when True =>
            Put_Line (Item => "Musikfehler: " & FehlermeldungExtern);
            raise MusikStopp;
            
         when False =>
            null;
      end case;
      
   end Musik;
   
   
   
   procedure Sound
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Soundfehler: " & FehlermeldungExtern);
      
      case
        DebugobjekteLogik.Debug.FehlerWarnung
      is
         when True =>
            Put_Line (Item => "Soundfehler: " & FehlermeldungExtern);
            raise SoundStopp;
            
         when False =>
            null;
      end case;
      
   end Sound;

end Fehlermeldungssystem;
