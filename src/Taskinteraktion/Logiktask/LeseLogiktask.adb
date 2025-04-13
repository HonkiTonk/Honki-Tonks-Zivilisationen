with Logiktask;

package body LeseLogiktask is
   
   function WartenSound
     return Boolean
   is begin
      
      return Logiktask.Warten.Sound;
      
   end WartenSound;
   
   
   
   function WartenMusik
     return Boolean
   is begin
      
      return Logiktask.Warten.Musik;
      
   end WartenMusik;
   
   
   
   function WartenGrafik
     return Boolean
   is begin
      
      return Logiktask.Warten.Grafik;
      
   end WartenGrafik;
   
   

   function WartenIntro
     return Boolean
   is begin
      
      return Logiktask.Warten.Intro;
      
   end WartenIntro;
   
   
   
   function Tastaturtaste
     return Sf.Window.Keyboard.sfKeyCode
   is begin
      
      return Logiktask.Eingabe.Tastaturtaste;
      
   end Tastaturtaste;
   
   
   
   function Maustaste
     return Sf.Window.Mouse.sfMouseButton
   is begin
      
      return Logiktask.Eingabe.Maustaste;
      
   end Maustaste;
   
   
   
   function ErfolgTexteingabe
     return Boolean
   is begin
      
      return Logiktask.Eingabe.Text.ErfolgreichAbbruch;
      
   end ErfolgTexteingabe;
   
   
   
   function Texteingabe
     return Unbounded_Wide_Wide_String
   is begin
      
      return Logiktask.Eingabe.Text.EingegebenerText;
      
   end Texteingabe;
   
   
   
   function KompletteTexteingabe
     return SystemRecordsHTSEB.TextEingabeRecord
   is begin
      
      return Logiktask.Eingabe.Text;
      
   end KompletteTexteingabe;
   
   
   
   function Scrollleiste
     return Boolean
   is begin
      
      return Logiktask.Scrollleiste;
      
   end Scrollleiste;

end LeseLogiktask;
