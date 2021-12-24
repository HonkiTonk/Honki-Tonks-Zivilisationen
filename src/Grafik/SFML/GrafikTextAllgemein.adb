pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.Text;

with Fehler;

package body GrafikTextAllgemein is

   -- Das hier als "globale" Aufrufprozedur verwenden und dann kleinere Sachen Aufrufen um die einzelnen Teile auch so zu nutzen? Sinnvoll oder zu kleinteilig und nutzlos?
   procedure TextAccessEinstellen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      FontAccessExtern : in Sf.Graphics.sfFont_Ptr;
      SchriftgrößeExtern : in Sf.sfUint32;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      if
        TextAccessExtern = null
      then
         Fehler.LogikStopp (FehlermeldungExtern => "GrafikTextAllgemein.TextAccessEinstellen - Access ist null.");
            
      else
         null;
      end if;
      
      Sf.Graphics.Text.setFont (text => TextAccessExtern,
                                font => FontAccessExtern);
      Sf.Graphics.Text.setCharacterSize (text => TextAccessExtern,
                                         size => SchriftgrößeExtern);
      Sf.Graphics.Text.setColor (text  => TextAccessExtern,
                                 color => FarbeExtern);
      
   end TextAccessEinstellen;

end GrafikTextAllgemein;
