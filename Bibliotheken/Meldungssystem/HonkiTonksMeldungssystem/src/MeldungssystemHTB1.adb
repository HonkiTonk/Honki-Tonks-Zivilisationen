with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with MeldungSchreibenHTB1;
with MeldungsvariablenHTB1;

package body MeldungssystemHTB1 is

   procedure Logik
     (MeldungExtern : in Wide_Wide_String)
   is begin
      
      MeldungSchreibenHTB1.Meldung (MeldungExtern => Logikfehler & MeldungExtern);
      
      case
        MeldungsvariablenHTB1.FehlerMeldungAbfragen
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
         
      MeldungSchreibenHTB1.Meldung (MeldungExtern => Grafikfehler & MeldungExtern);
      
      case
        MeldungsvariablenHTB1.FehlerMeldungAbfragen
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
      
      MeldungSchreibenHTB1.Meldung (MeldungExtern => Musikfehler & MeldungExtern);
      
      case
        MeldungsvariablenHTB1.FehlerMeldungAbfragen
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
      
      MeldungSchreibenHTB1.Meldung (MeldungExtern => Soundfehler & MeldungExtern);
      
      case
        MeldungsvariablenHTB1.FehlerMeldungAbfragen
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
      
      MeldungSchreibenHTB1.Meldung (MeldungExtern => SonstigeFehler & MeldungExtern);
      
      case
        MeldungsvariablenHTB1.FehlerMeldungAbfragen
      is
         when True =>
            Put_Line (Item => SonstigeFehler & MeldungExtern);
            raise SonstigesStopp;
            
         when False =>
            null;
      end case;
      
   end Sonstiges;

end MeldungssystemHTB1;
