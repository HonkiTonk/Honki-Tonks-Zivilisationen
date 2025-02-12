with Logiktask;

package body SchreibeLogiktask is
   
   procedure WartenSound
     (ZustandExtern : in Boolean)
   is begin
      
      Logiktask.Warten.Sound := ZustandExtern;
      
   end WartenSound;
   
   
   
   procedure WartenMusik
     (ZustandExtern : in Boolean)
   is begin
      
      Logiktask.Warten.Musik := ZustandExtern;
      
   end WartenMusik;
   
   
   
   procedure WartenGrafik
     (ZustandExtern : in Boolean)
   is begin
      
      Logiktask.Warten.Grafik := ZustandExtern;
      
   end WartenGrafik;
   
   

   procedure WartenIntro
     (ZustandExtern : in Boolean)
   is begin
      
      Logiktask.Warten.Intro := ZustandExtern;
      
   end WartenIntro;
   
   
   
   procedure Tastaturtaste
     (TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is begin
      
      Logiktask.Eingabe.Tastaturtaste := TasteExtern;
      
   end Tastaturtaste;
   
   
   
   procedure Maustaste
     (TasteExtern : in Sf.Window.Mouse.sfMouseButton)
   is begin
      
      Logiktask.Eingabe.Maustaste := TasteExtern;
      
   end Maustaste;
   
   
   
   procedure ErfolgTexteingabe
     (ErfolgExtern : in Boolean)
   is begin
      
      Logiktask.Eingabe.Text.ErfolgreichAbbruch := ErfolgExtern;
      
   end ErfolgTexteingabe;
   
   
   
   procedure Texteingabe
     (TextExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      Logiktask.Eingabe.Text.EingegebenerText := TextExtern;
      
   end Texteingabe;
   
   
   
   procedure KompletteTexteingabe
     (EingabeExtern : in SystemRecordsHTSEB.TextEingabeRecord)
   is begin
      
      Logiktask.Eingabe.Text := EingabeExtern;
      
   end KompletteTexteingabe;

end SchreibeLogiktask;
