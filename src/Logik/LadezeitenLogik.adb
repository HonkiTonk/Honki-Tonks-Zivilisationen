package body LadezeitenLogik is
   
   procedure KartengeneratorNullsetzen
   is begin
      
      Kartengenerator := (others => AnfangLadezeit);
      
   end KartengeneratorNullsetzen;
   
   
   
   procedure KartengeneratorSchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.Kartengenerator_Enum;
      ZeitExtern : in Float)
   is begin
      
      Kartengenerator (BerechnungszeitExtern) := LadezeitTesten (GrundwertExtern  => Kartengenerator (BerechnungszeitExtern),
                                                                 ZusatzwertExtern => ZeitExtern);
      
   end KartengeneratorSchreiben;
   
   
   
   procedure KartengeneratorMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Kartengenerator_Enum)
   is begin
   
      Kartengenerator (BerechnungszeitExtern) := EndeLadezeit;
      
   end KartengeneratorMaximum;
   
   
   
   procedure KINullsetzen
   is begin
      
      KI := (others => AnfangLadezeit);
      
   end KINullsetzen;
   
   
   
   procedure KIEinzelnNullsetzen
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum)
   is begin
      
      KI (BerechnungszeitExtern) := AnfangLadezeit;
      
   end KIEinzelnNullsetzen;
   
   
   
   procedure KISchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum;
      ZeitExtern : in Float)
   is begin
      
      KI (BerechnungszeitExtern) := LadezeitTesten (GrundwertExtern  => KI (BerechnungszeitExtern),
                                                    ZusatzwertExtern => ZeitExtern);
      
   end KISchreiben;
   
   
   
   procedure KIMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Enum)
   is begin
      
      KI (BerechnungszeitExtern) := EndeLadezeit;
      
   end KIMaximum;
   
      
   
   procedure RundenendeNullsetzen
   is begin
      
      Rundenende := AnfangLadezeit;
      
   end RundenendeNullsetzen;
   
   
   
   procedure RundenendeSchreiben
     (ZeitExtern : in Float)
   is begin
      
      Rundenende := LadezeitTesten (GrundwertExtern  => Rundenende,
                                    ZusatzwertExtern => ZeitExtern);
      
   end RundenendeSchreiben;
   
   
   
   procedure RundenendeMaximum
   is begin
      
      Rundenende := EndeLadezeit;
      
   end RundenendeMaximum;
   
   
   
   procedure SpielstandNullsetzen
   is begin
      
      Spielstand := (others => AnfangLadezeit);
      
   end SpielstandNullsetzen;
   
   
   
   procedure SpielstandSchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielstand_Enum;
      ZeitExtern : in Float)
   is begin
            
      Spielstand (BerechnungszeitExtern) := LadezeitTesten (GrundwertExtern  => Spielstand (BerechnungszeitExtern),
                                                            ZusatzwertExtern => ZeitExtern);
      
   end SpielstandSchreiben;
   
   
   
   procedure SpielstandMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielstand_Enum)
   is begin
      
      Spielstand (BerechnungszeitExtern) := EndeLadezeit;
      
   end SpielstandMaximum;

end LadezeitenLogik;
