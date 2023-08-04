with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with Projekteinstellungen;

with FehlermeldungSchreiben;

package body Fehlermeldungssystem is

   procedure Logik
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Logikfehler: " & FehlermeldungExtern);
      
      case
        Projekteinstellungen.Debug.FehlerWarnung
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
        Projekteinstellungen.Debug.FehlerWarnung
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
        Projekteinstellungen.Debug.FehlerWarnung
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
        Projekteinstellungen.Debug.FehlerWarnung
      is
         when True =>
            Put_Line (Item => "Soundfehler: " & FehlermeldungExtern);
            raise SoundStopp;
            
         when False =>
            null;
      end case;
      
   end Sound;
   
   
   
   procedure Mehrfachverwendung
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Mehrfachfehler: " & FehlermeldungExtern);
      
      case
        Projekteinstellungen.Debug.FehlerWarnung
      is
         when True =>
            Put_Line (Item => "Mehrfachfehler: " & FehlermeldungExtern);
            raise MehrfachverwendungStopp;
            
         when False =>
            null;
      end case;
      
   end Mehrfachverwendung;

end Fehlermeldungssystem;
