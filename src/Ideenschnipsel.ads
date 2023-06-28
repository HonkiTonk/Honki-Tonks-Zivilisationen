procedure Test
  -- DateiExtern muss entweder out oder in out sein.
  (DateiExtern : out File_Type;
   AAA : in Exception_Occurrence);

procedure Test
  (DateiExtern : out File_Type;
   AAA : in Exception_Occurrence)
is begin
   
   -- Es gibt dann aber keine Möglichkeit mehr das in verschiedenen Tasks zu verwenden.
   -- Ich müsste also entweder die Taskart mit übergeben oder darauf verzichten, was natürlich die Informationsmenge reduziert.
   Fehlermeldungssystem.Logik (FehlermeldungExtern => Decode (Item => Exception_Information (X => AAA)));
                                              
   case
     Is_Open (File => DateiExtern)
   is
      when True =>
         Close (File => DateiExtern);
               
      when False =>
         null;
   end case;
      
end Test;



AktuelleAuflösung := FensterGrafik.AktuelleAuflösung;
      
if
  LetzteAuflösung.x /= AktuelleAuflösung.x
  or
    LetzteAuflösung.y /= AktuelleAuflösung.y
then
   -- Hier da dann Die Viewberechnung/Textpositionsberechnung einbauen. Kann das funktionieren?
   -- Eventuell doch zwei Schleifen machen, einmal die Berechnung und einmal die Anzeige.
   -- Wenn ich die Positionen der Texte auch noch in einem Array speichere, als Texthöhe immer meinen Texthöhenaccess verwende, dann brauche ich nur bei Auflösungsänderungen die Werte neu berechnen.
   -- Wäre vermutlich schneller. Aber ist das relevant/sinnvoll/nützlich?
   LetzteAuflösung := AktuelleAuflösung;
         
else
   null;
end if;

-- Hier dann die Anzeige platzieren.
