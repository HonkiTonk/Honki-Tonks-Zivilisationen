pragma SPARK_Mode (On);

with Sf.Graphics.Text;

package body GrafikTextAllgemein is

   -- Das hier als "globale" Aufrufprozedur verwenden und dann kleinere Sachen Aufrufen um die einzelnen Teile auch so zu nutzen? Sinnvoll oder zu kleinteilig und nutzlos?
   procedure TextAccessEinstellen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      FontExtern : in Sf.Graphics.sfFont_Ptr;
      SchriftgrößeExtern : in Sf.sfUint32;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Text.setFont (text => TextAccessExtern,
                                font => FontExtern);
      Sf.Graphics.Text.setCharacterSize (text => TextAccessExtern,
                                         size => SchriftgrößeExtern);
      Sf.Graphics.Text.setColor (text  => TextAccessExtern,
                                 color => FarbeExtern);
      
   end TextAccessEinstellen;

end GrafikTextAllgemein;