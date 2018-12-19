require_relative '../lib/Register.rb'

describe "Checking StudentSubject class initialization" do
  before{
    @studentSubject = StudentSubject.new
  }

  it "Returns not nil while created" do
    expect(@studentSubject).not_to be nil
  end

  it "Returns instance of Note while created" do
    expect(@studentSubject).to be_instance_of(StudentSubject)
  end

  it "Note is a subclass of Sequel::Model" do
    expect(@studentSubject).to be_a(Sequel::Model)
  end


  after{
    @studentSubject = nil
  }

end

describe "Checking StudentSubject Class functionality" do

  before {
    @test_student = Student.new
    @test_student[:name] = "Test"
    @test_student[:surname] = "Student"
    @test_student.save

    @test_teacher = Teacher.new
    @test_teacher[:name] = "Test"
    @test_teacher[:surname] = "Teacher"
    @test_teacher.save

    @test_subject = Subject.new
    @test_subject[:name] = "Test"
    @test_subject[:Teacher_id] = @test_teacher[:id]
    @test_subject.save

    @pre_add_len = StudentSubject.dataset.count

    @studentSubject = StudentSubject.new
    @studentSubject[:Student_id] = @test_student[:id]
    @studentSubject[:Subject_id] = @test_subject[:id]
    @studentSubject.save

    @post_add_len = StudentSubject.dataset.count
  }

  it "Inserting value should increase dataset length" do
    expect(StudentSubject.dataset.count).to eq(@pre_add_len+1)
  end

  it "Checking if value is inserted correctly" do
    expect(StudentSubject.last).to eq(@studentSubject)
  end

  it "Updating value shouldn't increase dataset length" do
    @updated_studentSubject = StudentSubject.last

    @test_update_student = Student.new
    @test_update_student[:name] = "Update"
    @test_update_student[:surname] = "Test-Student"
    @test_update_student.save

    @updated_studentSubject[:Student_id] = @test_update_student[:id]
    @updated_studentSubject.save
    expect(StudentSubject.dataset.count).to eq(@post_add_len)
  end

  it "Checking if value is updated correctly" do
    @updated_studentSubject = StudentSubject.last

    @test_update_student = Student.new
    @test_update_student[:name] = "Update"
    @test_update_student[:surname] = "Test-Student"
    @test_update_student.save

    @updated_studentSubject[:Student_id] = @test_update_student[:id]
    @updated_studentSubject.save
    expect(StudentSubject.last).to eq(@updated_studentSubject)
  end

  it "Deleting value should decrease dataset length" do
    # skip("no mocks implemented")
    @removed_studentSubject = StudentSubject.last
    @removed_studentSubject.delete
    expect(StudentSubject.dataset.count).to eq(@post_add_len-1)
  end

  it "Checking if value is removed correctly" do
    # skip("no mocks implemented")
    @removed_studentSubject = StudentSubject.last
    @removed_studentSubject.delete
    expect(StudentSubject.last).not_to eq(@removed_studentSubject)
  end

  after{
    @test_teacher = nil
    @test_subject = nil
    @test_student = nil
    @test_update_student = nil
    @studentSubject = nil
  }


end