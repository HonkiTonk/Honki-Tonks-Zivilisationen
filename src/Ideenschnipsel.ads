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
