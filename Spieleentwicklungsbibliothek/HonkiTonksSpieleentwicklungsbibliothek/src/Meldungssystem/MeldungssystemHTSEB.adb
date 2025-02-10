with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with MeldungSchreibenHTSEB;
with MeldungsvariablenHTSEB;

package body MeldungssystemHTSEB is

   procedure Logik
     (MeldungExtern : in Wide_Wide_String)
   is begin
      
      MeldungSchreibenHTSEB.Meldung (MeldungExtern => Logikfehler & MeldungExtern);
      
      case
        MeldungsvariablenHTSEB.FehlerMeldungAbfragen
      is
         when True =>
            Put_Line (Item => Logikfehler & MeldungExtern);
            raise LogikStopp;
            
         when False =>
            null;
      end case;
      
   end Logik;
   
   
   
   procedure Grafik
     (MeldungExtern : in Wide_Wide_String)
   is begin
         
      MeldungSchreibenHTSEB.Meldung (MeldungExtern => Grafikfehler & MeldungExtern);
      
      case
        MeldungsvariablenHTSEB.FehlerMeldungAbfragen
      is
         when True =>
            Put_Line (Item => Grafikfehler & MeldungExtern);
            raise GrafikStopp;
            
         when False =>
            null;
      end case;
      
   end Grafik;
   
   
   
   procedure Musik
     (MeldungExtern : in Wide_Wide_String)
   is begin
      
      MeldungSchreibenHTSEB.Meldung (MeldungExtern => Musikfehler & MeldungExtern);
      
      case
        MeldungsvariablenHTSEB.FehlerMeldungAbfragen
      is
         when True =>
            Put_Line (Item => Musikfehler & MeldungExtern);
            raise MusikStopp;
            
         when False =>
            null;
      end case;
      
   end Musik;
   
   
   
   procedure Sound
     (MeldungExtern : in Wide_Wide_String)
   is begin
      
      MeldungSchreibenHTSEB.Meldung (MeldungExtern => Soundfehler & MeldungExtern);
      
      case
        MeldungsvariablenHTSEB.FehlerMeldungAbfragen
      is
         when True =>
            Put_Line (Item => Soundfehler & MeldungExtern);
            raise SoundStopp;
            
         when False =>
            null;
      end case;
      
   end Sound;
   
   
   
   procedure Sonstiges
     (MeldungExtern : in Wide_Wide_String)
   is begin
      
      MeldungSchreibenHTSEB.Meldung (MeldungExtern => SonstigeFehler & MeldungExtern);
      
      case
        MeldungsvariablenHTSEB.FehlerMeldungAbfragen
      is
         when True =>
            Put_Line (Item => SonstigeFehler & MeldungExtern);
            raise SonstigesStopp;
            
         when False =>
            null;
      end case;
      
   end Sonstiges;

end MeldungssystemHTSEB;
