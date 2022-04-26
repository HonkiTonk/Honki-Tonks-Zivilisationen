pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartengeneratorEisWasserLand is
   
   procedure AufteilungEisWasserLand;
   
private
   
   procedure AllgemeineWerteFestlegen;
   procedure KartengeneratorStandardSonstiges;

end KartengeneratorEisWasserLand;
